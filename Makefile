# Makefile
# Original by Kevin Robayna - http://kevinrobayna.eu
SHELL := /bin/bash
.PHONY: linux mac

define backup
	-mv -i ~/.bash_scripts ~/.bash_scripts.backup
	-mv -i ~/.vim ~/.vim.backup
	-mv -i ~/.bash_aliases ~/.bash_aliases.backup
	-mv -i ~/.bash_profile ~/.bash_profile.backup
	-mv -i ~/.bash_prompt ~/.bash_prompt.backup
	-mv -i ~/.bashrc ~/.bashrc.backup
	-mv -i ~/.gitconfig ~/.gitconfig.backup
	-mv -i ~/.gitignore ~/.gitignore.backup
	-mv -i ~/.tmux.conf ~/.tmux.conf.backup
	-mv -i ~/.vimrc ~/.vimrc.backup
endef

define cc_backup
	-mv -i ~/datos/homes.rala/perfil-ubuntu12.04/.bash_scripts ~/datos/homes.rala/perfil-ubuntu12.04/.bash_scripts.backup
	-mv -i ~/datos/homes.rala/perfil-ubuntu12.04/.ipython ~/datos/homes.rala/perfil-ubuntu12.04/.ipython.backup
	-mv -i ~/datos/homes.rala/perfil-ubuntu12.04/.config/ipython ~/datos/homes.rala/perfil-ubuntu12.04/.config/ipython.backup
	-mv -i ~/datos/homes.rala/perfil-ubuntu12.04/.vim ~/datos/homes.rala/perfil-ubuntu12.04/.vim.backup
	-mv -i ~/datos/homes.rala/perfil-ubuntu12.04/.bash_aliases ~/datos/homes.rala/perfil-ubuntu12.04/.bash_aliases.backup
	-mv -i ~/datos/homes.rala/perfil-ubuntu12.04/.bash_profile ~/datos/homes.rala/perfil-ubuntu12.04/.bash_profile.backup
	-mv -i ~/datos/homes.rala/perfil-ubuntu12.04/.bash_prompt ~/datos/homes.rala/perfil-ubuntu12.04/.bash_prompt.backup
	-mv -i ~/datos/homes.rala/perfil-ubuntu12.04/.bashrc ~/datos/homes.rala/perfil-ubuntu12.04/.bashrc.backup
	-mv -i ~/datos/homes.rala/perfil-ubuntu12.04/.gitconfig ~/datos/homes.rala/perfil-ubuntu12.04/.gitconfig.backup
	-mv -i ~/datos/homes.rala/perfil-ubuntu12.04/.gitignore ~/datos/homes.rala/perfil-ubuntu12.04/.gitignore.backup
	-mv -i ~/datos/homes.rala/perfil-ubuntu12.04/.tmux.conf ~/datos/homes.rala/perfil-ubuntu12.04/.tmux.conf.backup
	-mv -i ~/datos/homes.rala/perfil-ubuntu12.04/.vimrc ~/datos/homes.rala/perfil-ubuntu12.04/.vimrc.backup
endef

#Initialize environment on CC-ETSII
cc:
	git submodule init
	git submodule update
	$(call cc_backup)
	ln -s `pwd`/.bash_scripts ~/datos/homes.rala/perfil-ubuntu12.04/.bash_scripts
	mkdir -p ~/datos/homes.rala/perfil-ubuntu12.04/.config
	ln -s `pwd`/.ipython ~/datos/homes.rala/perfil-ubuntu12.04/.config/ipython
	ln -s `pwd`/.vim ~/datos/homes.rala/perfil-ubuntu12.04/.vim
	ln -s `pwd`/.bash_aliases ~/datos/homes.rala/perfil-ubuntu12.04/.bash_aliases
	ln -s `pwd`/.bash_profile ~/datos/homes.rala/perfil-ubuntu12.04/.bash_profile
	ln -s `pwd`/.bash_prompt ~/datos/homes.rala/perfil-ubuntu12.04/.bash_prompt
	ln -s `pwd`/.bashrc ~/datos/homes.rala/perfil-ubuntu12.04/.bashrc
	ln -s `pwd`/.gitconfig-dummy ~/datos/homes.rala/perfil-ubuntu12.04/.gitconfig
	ln -s `pwd`/.gitignore-dummy ~/datos/homes.rala/perfil-ubuntu12.04/.gitignore
	ln -s `pwd`/.tmux.conf ~/datos/homes.rala/perfil-ubuntu12.04/.tmux.conf
	ln -s `pwd`/.vimrc ~/datos/homes.rala/perfil-ubuntu12.04/.vimrc


# Initialize environment on Linux
linux:
	git submodule init
	git submodule update
	$(call backup)
	ln -s `pwd`/bash_scripts ~/.bash_scripts
	mkdir -p ~/.config
	ln -s `pwd`/.ipython ~/.config/ipython
	ln -s `pwd`/.vim ~/.vim
	ln -s `pwd`/.bash_aliases ~/.bash_aliases
	ln -s `pwd`/.bash_profile ~/.bash_profile
	ln -s `pwd`/.bash_prompt ~/.bash_prompt
	ln -s `pwd`/.bashrc ~/.bashrc
	ln -s `pwd`/.gitconfig-dummy ~/.gitconfig
	ln -s `pwd`/.gitignore-dummy ~/.gitignore
	ln -s `pwd`/.tmux.conf ~/.tmux.conf
	ln -s `pwd`/.vimrc ~/.vimrc

# Initialize environment on Mac
mac:
	$(call backup)
	ln -s `pwd`/oh-my-zsh/templates/zshrc.zsh-template ~/.zshrc
	chsh -s /bin/zsh
	ln -s `pwd`/.vim ~/.vim
	ln -s `pwd`/.gitconfig-dummy ~/.gitconfig
	ln -s `pwd`/.gitignore-dummy ~/.gitignore
	ln -s `pwd`/.tmux.conf ~/.tmux.conf
	ln -s `pwd`/.vimrc ~/.vimrc
	mkdir -p ~/Library/Developer/Xcode/UserData/FontAndColorThemes/
	ln -s `pwd`/XCode/*.dvtcolortheme ~/Library/Developer/Xcode/UserData/FontAndColorThemes/
	mkdir -p ~/Library/Fonts
	ln -s `pwd`/Fonts/* ~/Library/Fonts/

# Install python dependencies
deps:
	easy_install pip
	easy_install ipython
	easy_install flake8
	pip install virtualenvwrapper

# Remove backup files
rm:
	rm -Rf ~/.*.backup

