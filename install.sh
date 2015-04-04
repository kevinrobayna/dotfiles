# Makefile
# Original by Kevin Robayna - http://kevinrobayna.com
SHELL := /usr/local/bin/zsh

# Start
echo "`basename $0` starting."

if [ -d "/Applications/Xcode.app" ]; then
	workstation=$HOME/Workstation
	# Initialize environment on Mac
	[[ ! -d $workstation ]] && mkdir -p $workstation
	git clone https://github.com/kevinrobayna/dotfiles.git $workstation

	directory=$workstation/dotfiles
	cd $directory
	git submodule init
	git submodule update --recursive

	$directory/.osx
	$directory/.brew
	$directory/.preferences

	cp -r $directory/XCode-Themes/ $HOME/Library/Developer/Xcode/UserData/FontAndColorThemes/

	sh -c "`curl -fsSL https://raw.githubusercontent.com/skwp/dotfiles/master/install.sh`" -s ask

	ln -f -s aliases.zsh $HOME/.zsh.after/aliases.zsh
	ln -f -s prompt.zsh $HOME/.zsh.after/prompt.zsh
	ln -f -s prompt_kevinrobayna_setup $HOME/.zsh.prompt/prompt_kevinrobayna_setup
else
    echo "Kevin, install the Xcode first..."
fi

# Finished
echo "`basename $0` complete."