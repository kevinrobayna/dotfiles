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

curl https://www.toptal.com/developers/gitignore/api/macos,intellij+all,visualstudiocode,vim,goland+all,rubymine+all,pycharm+all -o ~/.gitignore

git config --global user.name "Kevin Robayna"
git config --global user.email me@kevinrobayna.com
git config --global commit.gpgsign true
git config --global core.excludesfile ~/.gitignore
git config --global pull.rebase false
git config --global init.defaultBranch master
git config --global core.editor "vim"

# This is to ensure i can pull without creating a commit when i can but automatically create one if i need to
# I never do anything else other than git pull so this is the best way for me
git config --global merge.ff no
git config --global merge.commit no
git config --global pull.ff yes

# Kitty
rm -Rf ~/.config/kitty
ln -s "$PWD/.config/kitty" ~/.config/kitty

# Nvim
ln -s "$PWD/.config/nvim" ~/.config/nvim

# Tmux
ln -s "$PWD/.tmux.conf" ~/.tmux.conf

# lazygit
ln -s "$PWD/.config/lazygit" ~/.config/lazygit


# Finished
echo "`basename $0` complete."

# Remind to run p10k configure
echo "Now you should run p10k configure to configure p10k fonts"
