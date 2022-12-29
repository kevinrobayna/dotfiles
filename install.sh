# Makefile
# Original by Kevin Robayna - http://kevinrobayna.com
SHELL := /usr/local/bin/zsh

# Start
echo "`basename $0` starting."

echo "Instaling Homebrew"
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew doctor

# Link Homebrew casks in `/Applications` rather than `~/Applications`
export HOMEBREW_CASK_OPTS="--appdir=/Applications"

brew bundle

ln -s "$PWD/.zshrc" ~/.zshrc
ln -s "$PWD/.tool-versions" ~/.tool-versions
ln -s "$PWD/.asdfrc" ~/.asdfrc

touch ~/.secrets
touch ~/.zsh_history

sh .osx

asdf plugin add java
asdf plugin add kotlin
asdf plugin add nodejs
asdf plugin add postgres
asdf plugin add python
asdf plugin add ruby
asdf plugin add golang
asdf plugin add rust

curl https://www.toptal.com/developers/gitignore/api/macos,intellij+all,rubymine+all,pycharm+all,visualstudiocode -o ~/.gitignore

git config --global user.name "Kevin Robayna"
git config --global user.email me@kevinrobayna.com
git config --global commit.gpgsign true
git config --global core.excludesfile ~/.gitignore
git config --global pull.rebase false

curl -L https://iterm2.com/shell_integration/zsh -o ~/.iterm2_shell_integration.zsh

# Vim
bash <(curl -s https://raw.githubusercontent.com/lunarvim/lunarvim/master/utils/installer/install.sh)
rm ~/.config/lvim/config.lua
ln -s "$PWD/config.lua" ~/.config/lvim/config.lua

# Finished
echo "`basename $0` complete."

# Remind to run p10k configure
echo "Now you should run p10k configure to configure p10k fonts"
