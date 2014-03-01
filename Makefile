# Makefile
# Original by Kevin Robayna - http://kevinrobayna.eu
SHELL := /bin/zsh
.PHONY: linux mac

# Initialize environment on Mac
mac:
	git submodule init
	git submodule update
	ln -s `pwd`/.oh-my-zsh ~/.oh-my-zsh
	ln -s `pwd`/.zshrc ~/.zshrc
	chsh -s /bin/zsh
	ln -s `pwd`/.vim ~/.vim
	ln -s `pwd`/.gitconfig-dummy ~/.gitconfig
	ln -s `pwd`/.gitignore-dummy ~/.gitignore
	ln -s `pwd`/.tmux.conf ~/.tmux.conf
	ln -s `pwd`/.vimrc ~/.vimrc

# Install python dependencies
deps:
	easy_install pip
	easy_install ipython
	easy_install flake8
	pip install virtualenvwrapper

# Remove backup files
rm:
	rm -Rf ~/.*.backup

