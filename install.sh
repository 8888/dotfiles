#!/bin/bash

dir=~/.dotfiles

## create symlinks for dotfiles
ln -s ${dir}/.bash_profile ~/.bash_profile
ln -s ${dir}/.gitconfig ~/.gitconfig
ln -s ${dir}/.vimrc ~/.vimrc
