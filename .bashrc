# .bashrc
#  Original by Kevin Robayna - http://kevinrobayna.eu 

# Disallow duplicates in history
HISTCONTROL=ignoredups:ignorespace

# Keep 1000 lines in history
export HISTSIZE=1000
export HISTFILESIZE=1000

# Individually append lines to history and set window title
shopt -s histappend

# Use vim as default editor
export EDITOR=vim
export VISUAL=vim

# Remove default Ctrl-S behavior
stty -ixon -ixoff

# Add Heroku toolkit to path
export PATH="/usr/local/heroku/bin:$PATH"

# Use local binaries
export PATH=~/.local/bin:$PATH

# Use full color
export TERM=xterm-256color

# Store Go code in home directory
export GOPATH=$HOME/.gocode

# Predictable SSH authentication socket location.
# From http://unix.stackexchange.com/a/76256
SOCK="/tmp/ssh-agent-$USER-screen"
if test $SSH_AUTH_SOCK && [ $SSH_AUTH_SOCK != $SOCK ]
then
    rm -f /tmp/ssh-agent-$USER-screen
    ln -sf $SSH_AUTH_SOCK $SOCK
    export SSH_AUTH_SOCK=$SOCK
fi

# Import smartcd config
[ -r "$HOME/.smartcd_config" ] && ( [ -n $BASH_VERSION ] || [ -n $ZSH_VERSION ] ) && source ~/.smartcd_config

# Enable programmable completion
if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi

# Enable git bash completion
. ~/.bash_scripts/git-completion.bash

# Enable git prompt
. ~/.bash_scripts/git-prompt.bash

# Enable pwd prompt
. ~/.bash_scripts/pwd-prompt.bash

# Enable ta bash completion
. ~/.bash_scripts/ta-completion.bash

# Include alias definitions
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# Include custom bash prompt
if [ -f ~/.bash_prompt ]; then
    . ~/.bash_prompt
fi

# Execute .bash_local
if [ -f ~/.bash_local ]; then
    . ~/.bash_local
fi

PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
