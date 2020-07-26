#!/bin/bash

dir=~/.dotfiles

## create symlinks for dotfiles
ln -s ${dir}/.bash_profile ~/.bash_profile
ln -s ${dir}/.gitconfig ~/.gitconfig
ln -s ${dir}/.gitignore_global ~/.gitignore_global
ln -s ${dir}/.p10k.zsh ~/.p10k.zsh
ln -s ${dir}/.vimrc ~/.vimrc
ln -s ${dir}/.zshrc ~/.zshrc
