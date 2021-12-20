# Makefile
# Original by Kevin Robayna - http://kevinrobayna.com
SHELL := /usr/local/bin/zsh

# Start
echo "`basename $0` starting."

sh .brew

ln -s "$PWD/.zshrc" ~/.zshrc

touch ~/.secrets
touch ~/.zsh_history

sh .osx

curl https://www.toptal.com/developers/gitignore/api/macos,intellij+all,rubymine+all,pycharm+all,java,ruby,python,visualstudiocode -o ~/.gitignore

git config --global user.name "Kevin Robayna"
git config --global user.email me@kevinrobayna.com
git config --global commit.gpgsign true
git config --global core.excludesfile ~/.gitignore

# Finished
echo "`basename $0` complete."

# Remind to run p10k configure
echo "Now you should run p10k configure to configure p10k fonts"
