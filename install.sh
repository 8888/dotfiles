#!/bin/bash

dir=~/.dotfiles

## create symlinks for dotfiles
ln -s ${dir}/.aliases.zsh ~/.aliases.zsh
ln -s ${dir}/.bash_profile ~/.bash_profile
ln -s ${dir}/.gitconfig ~/.gitconfig
ln -s ${dir}/.gitignore_global ~/.gitignore_global
ln -s ${dir}/.p10k.zsh ~/.p10k.zsh
rm -rf ~/.lee # prevent recursive symlinking
ln -s ${dir}/.lee ~/.lee
ln -s ${dir}/.vimrc ~/.vimrc
ln -s ${dir}/.zshrc ~/.zshrc
ln -s ${dir}/gemini.settings.json ~/.gemini/settings.json
ln -s ${dir}/gemini/gemini.md ~/.gemini/gemini.md

## symlink for configs
# VS Code
rm ~/"Library/Application Support/Code/User/settings.json"
ln -s ${dir}/vscode/settings.json ~/"Library/Application Support/Code/User/settings.json"
# Cursor
rm ~/Library/Application\ Support/Cursor/User/settings.json
ln -s ${dir}/vscode/settings.json ~/Library/Application\ Support/Cursor/User/settings.json
