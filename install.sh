#!/bin/bash

dir=~/.dotfiles

## create symlinks for dotfiles
ln -s ${dir}/.aliases.zsh ~/.aliases.zsh
ln -s ${dir}/.bash_profile ~/.bash_profile
ln -s ${dir}/.gitconfig ~/.gitconfig
ln -s ${dir}/.gitignore_global ~/.gitignore_global
ln -s ${dir}/.p10k.zsh ~/.p10k.zsh
ln -s ${dir}/.lee ~/.lee
ln -s ${dir}/.vimrc ~/.vimrc
ln -s ${dir}/.zshrc ~/.zshrc

## symlink for configs
# VS Code
ln -s ${dir}/vscode/settings.json ~/"Library/Application Support/Code/User/settings.json"
# VS Code Insiders
# ln -s ${dir}/vscode/settings.json ~/"Library/Application Support/Code - Insiders/User/settings.json"
