# .bash_profile                                                          
#  Original by Kevin Robayna - http://kevinrobayna.eu

# Execute .bashrc
if [ -f ~/.bashrc ]; then
    . ~/.bashrc
fi

export PATH=/opt/local/bin:/opt/local/sbin:$PATH

# Load RVM into a shell session *as a function*
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" 
