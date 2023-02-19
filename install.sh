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

curl https://www.toptal.com/developers/gitignore/api/macos,intellij+all,visualstudiocode,vim,homebrew -o ~/.gitignore

git config --global user.name "Kevin Robayna"
git config --global user.email me@kevinrobayna.com
git config --global core.excludesfile ~/.gitignore
git config --global pull.rebase false
git config --global init.defaultBranch master
git config --global core.editor "vim"

# This is to ensure i can pull without creating a commit when i can but automatically create one if i need to
# I never do anything else other than git pull so this is the best way for me
git config --global merge.ff no
git config --global merge.commit no
git config --global pull.ff yes

# GPG Sign
git config --global commit.gpgsign true
# We need to configure which key we want to use to sign 
# We need first to list the available keys with the following command
#
# gpg --list-secret-keys --keyid-format=long
# 
# Which will output something like below:
#
# /Users/kevinrobayna/.gnupg/pubring.kbx
# --------------------------------------
# sec   rsa4096/EXAMPLE_KEY 2020-10-03 [SC]
#       NOT_RELEVANT
# uid                 [ultimate] Kevin Robayna (Personal Laptop) <me@kevinrobayna.com>
# ssb   rsa4096/NOT_RELEVANT 2020-10-03 [E]
#
# We need to call the command before with the Key id
# git config --global user.signingkey 2EBBCF382556544C
#
# See https://docs.github.com/en/authentication/managing-commit-signature-verification/telling-git-about-your-signing-key for more help

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
