#!/usr/bin/env bash

#****************************************************
#                 Description                       *
#                                                   *
#  Script for setup of Vim and Bash Configuration   *
#                                                   *
#           Author: Kevin Robayna                   *
#                                                   *
#****************************************************

ln -s `pwd`/.bash_scripts ~/.bash_scripts
mkdir -p ~/.config
ln -s `pwd`/.ipython ~/.config/ipython
ln -s `pwd`/.vim ~/.vim
ln -s `pwd`/.bash_aliases ~/.bash_aliases
ln -s `pwd`/.bash_prompt ~/.bash_prompt
ln -s `pwd`/.bashrc ~/.bashrc
ln -s `pwd`/.gitconfig-global ~/.gitconfig
ln -s `pwd`/.gitignore-global ~/.gitignore
ln -s `pwd`/.tmux.conf ~/.tmux.conf
ln -s `pwd`/.vimrc ~/.vimrc

