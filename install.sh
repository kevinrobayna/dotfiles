# Makefile
# Original by Kevin Robayna - http://kevinrobayna.com
SHELL := /usr/local/bin/zsh

# Start
echo "`basename $0` starting."

sh .brew

ln -s .zshrc ~
ln -s .p10k.zsh ~
ln -s .gitconfig ~

sh .osx

# Finished
echo "`basename $0` complete."
