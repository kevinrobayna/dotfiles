# Makefile
# Original by Kevin Robayna - http://kevinrobayna.com
SHELL := /usr/local/bin/zsh

# Start
echo "`basename $0` starting."

sh .brew

ln -s "$PWD/.zshrc" ~/.zshrc
ln -s "$PWD/.p10k.zsh" ~/.p10k.zsh

sh .osx

git config --global user.name "Kevin Robayna"
git config --global user.email me@kevinrobayna.com

# Finished
echo "`basename $0` complete."
