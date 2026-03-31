#!/bin/bash
set -eo pipefail

LOG_FILE=$(mktemp /tmp/dotfiles-install.log.XXXXXX)
trap 'echo "Install failed. See log: $LOG_FILE" >&2' ERR

# Colors only when stdout is a terminal and NO_COLOR is unset
if [ -t 1 ] && [ -z "${NO_COLOR:-}" ]; then
    GREEN='\033[0;32m'
    BLUE='\033[0;34m'
    RED='\033[0;31m'
    NC='\033[0m'
else
    GREEN='' BLUE='' RED='' NC=''
fi

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
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" >> "$LOG_FILE" 2>&1
    eval "$(/opt/homebrew/bin/brew shellenv)"
else
    echo -e "${BLUE}Homebrew already installed.${NC}"
fi

# Check for Oh My Zsh
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    echo -e "${BLUE}Installing Oh My Zsh...${NC}"
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended --keep-zshrc >> "$LOG_FILE" 2>&1
else
    echo -e "${BLUE}Oh My Zsh already installed.${NC}"
fi

# Install Oh My Zsh plugins & themes
ZSH_CUSTOM=${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}

if [ ! -d "$ZSH_CUSTOM/plugins/zsh-autosuggestions" ]; then
    echo -e "${BLUE}Installing zsh-autosuggestions...${NC}"
    git clone https://github.com/zsh-users/zsh-autosuggestions "$ZSH_CUSTOM/plugins/zsh-autosuggestions" >> "$LOG_FILE" 2>&1
fi

if [ ! -d "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting" ]; then
    echo -e "${BLUE}Installing zsh-syntax-highlighting...${NC}"
    git clone https://github.com/zsh-users/zsh-syntax-highlighting "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting" >> "$LOG_FILE" 2>&1
fi

if [ ! -d "$ZSH_CUSTOM/themes/powerlevel10k" ]; then
    echo -e "${BLUE}Installing Powerlevel10k...${NC}"
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$ZSH_CUSTOM/themes/powerlevel10k" >> "$LOG_FILE" 2>&1
fi

# Install Brew packages via Brewfile
echo -e "${BLUE}Installing packages from Brewfile...${NC}"
if [ -f "${dir}/Brewfile" ]; then
    brew bundle --file="${dir}/Brewfile" >> "$LOG_FILE" 2>&1
else
    echo -e "${RED}Brewfile not found in ${dir}${NC}" >&2
    exit 1
fi

PROFILE_BREWFILE="${dir}/Brewfile.${PROFILE}"
if [ -f "$PROFILE_BREWFILE" ]; then
    echo -e "${BLUE}Installing packages from Brewfile.${PROFILE}...${NC}"
    brew bundle --file="$PROFILE_BREWFILE" >> "$LOG_FILE" 2>&1
fi

if [ -f "/Applications/WezTerm.app/Contents/Resources/wezterm.sh" ]; then
    echo -e "${BLUE}Linking WezTerm shell integration...${NC}"
    ln -sf "/Applications/WezTerm.app/Contents/Resources/wezterm.sh" ~/.wezterm-shell-integration.sh
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
    ".vimrc"
    ".zshrc"
)

for file in "${links[@]}"; do
    rm -f ~/"$file"
    ln -sf "${dir}/${file}" ~/"$file"
done

# Profile-specific credential symlinks
if [ "$PROFILE" = "work" ]; then
    rm -f ~/.claude_credentials.work
    ln -sf "${dir}/.claude_credentials.work" ~/.claude_credentials.work
fi

# Legacy alias file cleanup (we now use aliases/*.zsh)
rm -f ~/.aliases.zsh

# Symlink .lee directory
rm -rf ~/.lee
ln -sf ${dir}/.lee ~/.lee

## symlink for configs
# VS Code
mkdir -p ~/Library/Application\ Support/Code/User
rm -f ~/"Library/Application Support/Code/User/settings.json"
ln -sf ${dir}/vscode/settings.json ~/"Library/Application Support/Code/User/settings.json"

# Claude Code
mkdir -p ~/.claude
rm -f ~/.claude/settings.json
ln -sf ${dir}/claude/settings.json ~/.claude/settings.json
rm -f ~/.claude/CLAUDE.md
ln -sf ${dir}/claude/CLAUDE.md ~/.claude/CLAUDE.md
rm -f ~/.claude/statusline-command.sh
ln -sf ${dir}/claude/statusline-command.sh ~/.claude/statusline-command.sh
chmod +x ${dir}/claude/statusline-command.sh
rm -f ~/.claude/chrome-devtools-mcp.sh
ln -sf ${dir}/claude/chrome-devtools-mcp.sh ~/.claude/chrome-devtools-mcp.sh
chmod +x ${dir}/claude/chrome-devtools-mcp.sh

# Claude Code skill commands
mkdir -p ~/.claude/commands
for skill_dir in "${dir}/agents/skills"/*/; do
    skill_name=$(basename "$skill_dir")
    skill_file="${skill_dir}SKILL.md"
    if [ -f "$skill_file" ]; then
        rm -f ~/.claude/commands/"${skill_name}.md"
        ln -sf "$skill_file" ~/.claude/commands/"${skill_name}.md"
    fi
done

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
rm -rf ~/.gemini/policies
ln -sf ${dir}/gemini/policies ~/.gemini/policies

# WezTerm
rm -f ~/.wezterm.lua
mkdir -p ~/.config
rm -rf ~/.config/wezterm
ln -sf ${dir}/wezterm ~/.config/wezterm
if [ ! -f ~/.wezterm_theme ]; then
    echo "PixelGrim" > ~/.wezterm_theme
fi

# Cleanup legacy paths
rm -f ~/.gemini/GEMINI.md
rm -rf ~/.gemini/antigravity
rm -rf ~/.agents
for dir_name in "workflows" "global_workflows" "skills" "global_skills" "rules"; do
    rm -rf "$HOME/.antigravity/$dir_name"
done

# Install spec-kit (specify CLI) — tracks main, upgrades on every install run
echo -e "${BLUE}Installing/upgrading spec-kit (specify CLI)...${NC}"
uv tool install --upgrade "specify-cli @ git+https://github.com/github/spec-kit.git@main" >> "$LOG_FILE" 2>&1

# Install Google Workspace CLI skills
echo -e "${BLUE}Installing Google Workspace CLI skills...${NC}"
if command -v skills &> /dev/null; then
    skills add --yes https://github.com/googleworkspace/cli >> "$LOG_FILE" 2>&1
else
    echo -e "${RED}Warning: 'skills' not in PATH, skipping Google Workspace CLI skills${NC}" >&2
fi

echo -e "${GREEN}Installation complete! Please restart your terminal or run 'source ~/.zshrc'${NC}"
echo "Full log: $LOG_FILE"
