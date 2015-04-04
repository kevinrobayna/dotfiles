# Makefile
# Original by Kevin Robayna - http://kevinrobayna.com
SHELL := /usr/local/bin/zsh

# Start
echo "`basename $0` starting."

workstation=~/Workstation

# Initialize environment on Mac
[[ ! -d ~/Workstation ]] && mkdir -p ~/Workstation
git clone https://github.com/kevinrobayna/dotfiles.git $workstation
xcode-select --install
sh -c "`curl -fsSL https://raw.githubusercontent.com/skwp/dotfiles/master/install.sh`" -s ask

directory=$workstation/dotfiles

ln -f -s aliases.zsh ~/.zsh.after/aliases.zsh
ln -f -s prompt.zsh ~/.zsh.after/prompt.zsh
ln -f -s prompt_kevinrobayna_setup ~/.zsh.prompt/prompt_kevinrobayna_setup

$directory/.osx
$directory/.brew
$directory/.preferences

# Finished
echo "`basename $0` complete."