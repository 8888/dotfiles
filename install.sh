#!/bin/bash

# Define colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
RED='\033[0;31m'
NC='\033[0m' # No Color

dir=~/dotfiles

# Determine profile
PROFILE=$1
if [ -z "$PROFILE" ]; then
    echo -e "${BLUE}No profile specified. Defaulting to 'home'.${NC}"
    echo -e "Usage: ./install.sh [home|work]"
    PROFILE="home"
fi

echo -e "${GREEN}Installing dotfiles with profile: $PROFILE${NC}"

# --- Prerequisites ---

# Check for Homebrew
if ! command -v brew &> /dev/null; then
    echo -e "${BLUE}Installing Homebrew...${NC}"
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    eval "$(/opt/homebrew/bin/brew shellenv)"
else
    echo -e "${BLUE}Homebrew already installed.${NC}"
fi

# Check for Oh My Zsh
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    echo -e "${BLUE}Installing Oh My Zsh...${NC}"
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended --keep-zshrc
else
    echo -e "${BLUE}Oh My Zsh already installed.${NC}"
fi

# Install Oh My Zsh plugins & themes
ZSH_CUSTOM=${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}

if [ ! -d "$ZSH_CUSTOM/plugins/zsh-autosuggestions" ]; then
    echo -e "${BLUE}Installing zsh-autosuggestions...${NC}"
    git clone https://github.com/zsh-users/zsh-autosuggestions "$ZSH_CUSTOM/plugins/zsh-autosuggestions"
fi

if [ ! -d "$ZSH_CUSTOM/themes/powerlevel10k" ]; then
    echo -e "${BLUE}Installing powerlevel10k...${NC}"
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$ZSH_CUSTOM/themes/powerlevel10k"
fi

# Install Brew packages via Brewfile
echo -e "${BLUE}Installing packages from Brewfile...${NC}"
if [ -f "${dir}/Brewfile" ]; then
    brew bundle --file="${dir}/Brewfile"
else
    echo -e "${RED}Brewfile not found in ${dir}${NC}"
fi

# --- Symlinking ---

# Save profile to file for .zshrc to read
echo "$PROFILE" > ~/.dotfiles_profile

## symlinks for dotfiles
# Remove existing files/links and create new ones
links=(
    ".bash_profile"
    ".gitconfig"
    ".gitignore_global"
    ".p10k.zsh"
    ".vimrc"
    ".zshrc"
)

for file in "${links[@]}"; do
    rm -f ~/"$file"
    ln -s "${dir}/${file}" ~/"$file"
done

# Legacy alias file cleanup (we now use aliases/*.zsh)
rm -f ~/.aliases.zsh

# Symlink .lee directory
rm -rf ~/.lee
ln -s ${dir}/.lee ~/.lee

## symlink for configs
# VS Code & Cursor
mkdir -p ~/Library/Application\ Support/Code/User
rm -f ~/"Library/Application Support/Code/User/settings.json"
ln -s ${dir}/vscode/settings.json ~/"Library/Application Support/Code/User/settings.json"

mkdir -p ~/Library/Application\ Support/Cursor/User
rm -f ~/Library/Application\ Support/Cursor/User/settings.json
ln -s ${dir}/vscode/settings.json ~/Library/Application\ Support/Cursor/User/settings.json

# Claude Code
mkdir -p ~/.claude
rm -f ~/.claude/settings.json
ln -sf ${dir}/claude/settings.json ~/.claude/settings.json
rm -f ~/.claude/CLAUDE.md
ln -sf ${dir}/claude/CLAUDE.md ~/.claude/CLAUDE.md

# Gemini CLI
mkdir -p ~/.gemini
if [ -f "${dir}/gemini/settings.json" ]; then
    echo -e "${BLUE}Configuring Gemini Settings...${NC}"
    # Expand {{HOME}} to ~/.gemini/settings.json (removes symlink if it exists to avoid truncation)
    rm -f ~/.gemini/settings.json
    sed "s|{{HOME}}|$HOME|g" "${dir}/gemini/settings.json" > ~/.gemini/settings.json
fi

# Process Trusted Folders Template
if [ -f "${dir}/gemini/trustedFolders.json" ]; then
    echo -e "${BLUE}Configuring Trusted Folders...${NC}"
    rm -f ~/.gemini/trustedFolders.json
    sed "s|{{HOME}}|$HOME|g" "${dir}/gemini/trustedFolders.json" > ~/.gemini/trustedFolders.json
fi

rm -f ~/.gemini/AGENTS.md
ln -sf ${dir}/gemini/AGENTS.md ~/.gemini/AGENTS.md
rm -rf ~/.gemini/docs
ln -sf ${dir}/agents/standards ~/.gemini/docs
rm -rf ~/.gemini/commands
ln -sf ${dir}/gemini/commands ~/.gemini/commands

# Cleanup legacy paths
rm -f ~/.gemini/GEMINI.md
rm -rf ~/.gemini/antigravity
rm -rf ~/.agents
for dir_name in "workflows" "global_workflows" "skills" "global_skills" "rules"; do
    rm -rf "$HOME/.antigravity/$dir_name"
done


echo -e "${GREEN}Installation complete! Please restart your terminal or run 'source ~/.zshrc'${NC}"
