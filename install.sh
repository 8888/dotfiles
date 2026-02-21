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

# Setup git content filters for gemini files
# This allows us to use real paths locally but commit __HOME__ placeholders
git -C "${dir}" config filter.gemini-home.clean "sed 's|${HOME}|__HOME__|g'"
git -C "${dir}" config filter.gemini-home.smudge "sed 's|__HOME__|${HOME}|g'"

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

# Gemini CLI & Antigravity Workflows
mkdir -p ~/.gemini
rm -f ~/.gemini/settings.json
ln -s ${dir}/gemini/settings.json ~/.gemini/settings.json
rm -f ~/.gemini/gemini.md
ln -s ${dir}/gemini/gemini.md ~/.gemini/gemini.md
rm -rf ~/.gemini/docs
ln -s ${dir}/gemini/docs ~/.gemini/docs
rm -rf ~/.gemini/commands
ln -s ${dir}/gemini/commands ~/.gemini/commands

# Compile Antigravity workflows
if [ -f "${dir}/.lee/bin/compile_workflows.py" ]; then
    echo -e "${BLUE}Compiling Antigravity Workflows...${NC}"
    python3 "${dir}/.lee/bin/compile_workflows.py"
fi

# Link Antigravity workflows globally
mkdir -p ~/.gemini/antigravity
rm -rf ~/.gemini/antigravity/global_workflows
ln -s ${dir}/.agents/workflows ~/.gemini/antigravity/global_workflows

# Cleanup legacy links
rm -rf ~/.agents

echo -e "${GREEN}Installation complete! Please restart your terminal or run 'source ~/.zshrc'${NC}"
