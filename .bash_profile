# .bash_profile                                                          
#  Original by Kevin Robayna - http://kevinrobayna.eu

# Execute .bashrc
if [ -f ~/.bashrc ]; then
    . ~/.bashrc
fi

export PATH=/opt/local/bin:/opt/local/sbin:$PATH

# Load RVM into a shell session *as a function*
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" 

##
# Your previous /Users/kevinrobayna/.bash_profile file was backed up as /Users/kevinrobayna/.bash_profile.macports-saved_2014-02-22_at_11:28:39
##

# MacPorts Installer addition on 2014-02-22_at_11:28:39: adding an appropriate PATH variable for use with MacPorts.
export PATH=/opt/local/bin:/opt/local/sbin:$PATH
# Finished adapting your PATH environment variable for use with MacPorts.

