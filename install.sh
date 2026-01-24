#!/bin/bash

# Define colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

dir=~/.dotfiles

# Determine profile
PROFILE=$1
if [ -z "$PROFILE" ]; then
    echo -e "${BLUE}No profile specified. Defaulting to 'home'.${NC}"
    echo -e "Usage: ./install.sh [home|work]"
    PROFILE="home"
fi

echo -e "${GREEN}Installing dotfiles with profile: $PROFILE${NC}"

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
git config filter.gemini-home.clean "sed 's|${HOME}|__HOME__|g'"
git config filter.gemini-home.smudge "sed 's|__HOME__|${HOME}|g'"

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

# Gemini
mkdir -p ~/.gemini
rm -f ~/.gemini/settings.json
ln -s ${dir}/gemini/settings.json ~/.gemini/settings.json
rm -f ~/.gemini/gemini.md
ln -s ${dir}/gemini/gemini.md ~/.gemini/gemini.md
rm -rf ~/.gemini/docs
ln -s ${dir}/gemini/docs ~/.gemini/docs
rm -rf ~/.gemini/commands
ln -s ${dir}/gemini/commands ~/.gemini/commands

echo -e "${GREEN}Installation complete! Please restart your terminal or run 'source ~/.zshrc'${NC}"