#!/bin/bash

dir=~/.dotfiles

## symlinks for dotfiles
rm ~/.aliases.zsh
ln -s ${dir}/.aliases.zsh ~/.aliases.zsh
rm ~/.bash_profile
ln -s ${dir}/.bash_profile ~/.bash_profile
rm ~/.gitconfig
ln -s ${dir}/.gitconfig ~/.gitconfig
rm ~/.gitignore_global
ln -s ${dir}/.gitignore_global ~/.gitignore_global
rm ~/.p10k.zsh
ln -s ${dir}/.p10k.zsh ~/.p10k.zsh
rm -rf ~/.lee
ln -s ${dir}/.lee ~/.lee
rm ~/.vimrc
ln -s ${dir}/.vimrc ~/.vimrc
rm ~/.zshrc
ln -s ${dir}/.zshrc ~/.zshrc

## symlink for configs
# VS Code
rm ~/"Library/Application Support/Code/User/settings.json"
ln -s ${dir}/vscode/settings.json ~/"Library/Application Support/Code/User/settings.json"

# Cursor
rm ~/Library/Application\ Support/Cursor/User/settings.json
ln -s ${dir}/vscode/settings.json ~/Library/Application\ Support/Cursor/User/settings.json

# Gemini
rm ~/.gemini/settings.json
ln -s ${dir}/gemini/settings.json ~/.gemini/settings.json
rm ~/.gemini/gemini.md
ln -s ${dir}/gemini/gemini.md ~/.gemini/gemini.md
rm -rf ~/.gemini/docs
ln -s ${dir}/gemini/docs ~/.gemini/docs
rm -rf ~/.gemini/commands
ln -s ${dir}/gemini/commands ~/.gemini/commands
