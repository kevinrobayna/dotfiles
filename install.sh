# Makefile
# Original by Kevin Robayna - http://kevinrobayna.com
SHELL := /usr/local/bin/zsh

# Start
echo "`basename $0` starting."

if [ -d "/Applications/Xcode.app" ]; then
	directory=$dev/dotfiles
	cd $directory

	$directory/.brew

	sh -c "`curl -fsSL https://raw.githubusercontent.com/skwp/dotfiles/master/install.sh`" -s ask

	cp aliases.zsh $HOME/.zsh.after/aliases.zsh
	cp prompt.zsh $HOME/.zsh.after/prompt.zsh
	cp prompt_kevinrobayna_setup $HOME/.zsh.prompts/prompt_kevinrobayna_setup

	cd ~/dev
	git clone https://github.com/benjohnde/Clipinio.git
	cd ~/dev/Clipinio
	./build.sh

  git config --global user.name "Kevin Robayna"
  git config --global user.email me@kevinrobayna.com
	
else
    echo "Kevin, install the Xcode first..."
fi

# Finished
echo "`basename $0` complete."
