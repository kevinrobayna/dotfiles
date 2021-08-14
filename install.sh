# Makefile
# Original by Kevin Robayna - http://kevinrobayna.com
SHELL := /usr/local/bin/zsh

# Start
echo "`basename $0` starting."

directory=$dev/dotfiles
cd $directory

sh $directory/.brew

ln -s $directory/.zshrc ~
ln -s $directory/.p10k.zsh ~

sh $directory/.osx

git config --global user.name "Kevin Robayna"
git config --global user.email me@kevinrobayna.com

# Finished
echo "`basename $0` complete."
