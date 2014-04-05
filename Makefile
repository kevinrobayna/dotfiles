# Makefile
# Original by Kevin Robayna - http://kevinrobayna.eu
SHELL := /usr/local/bin/zsh
.PHONY: mac

# Initialize environment on Mac
mac:
	git submodule init
	git submodule update
	ln -s `pwd`/.oh-my-zsh ~/.oh-my-zsh
	ln -s `pwd`/.zshrc ~/.zshrc
	chsh -s /usr/local/bin/zsh
	ln -s `pwd`/.vim ~/.vim
	ln -s `pwd`/.githelpers ~/.githelpers
	ln -s `pwd`/.gvimrc ~/.gvimrc
	ln -s `pwd`/.irbrc ~/.irbrc
	ln -s `pwd`/.profile ~/.profile
	ln -s `pwd`/.pryrc ~/.pryrc
	ln -s `pwd`/.gitconfig-dummy ~/.gitconfig
	ln -s `pwd`/.gitignore-dummy ~/.gitignore
	ln -s `pwd`/.vimrc ~/.vimrc
