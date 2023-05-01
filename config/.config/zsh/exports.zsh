#!bin/zsh

# Increase size of file
HISTSIZE=1000000
SAVEHIST=1000000
HISTFILESIZE=1000000000

# Immediate append
setopt INC_APPEND_HISTORY
export HISTTIMEFORMAT="[%F %T] "
export HISTCONTROL=ignoredups:erasedups # avoid duplicates..

setopt EXTENDED_HISTORY          # write the history file in the ":start:elapsed;command" format.
setopt HIST_REDUCE_BLANKS        # remove superfluous blanks before recording entry.
setopt HIST_IGNORE_ALL_DUPS      # delete old recorded entry if new entry is a duplicate.
setopt SHARE_HISTORY             # share history between all sessions.

# enable commit signing
# export GPG_TTY=$TTY is faster but jetbrains does not like it
# export GPG_TTY=$(tty)
export GPG_TTY=$TTY

# Link Homebrew casks in `/Applications` rather than `~/Applications`
export HOMEBREW_CASK_OPTS="--appdir=/Applications"

# Use vi as the default editor
export EDITOR="nvim"

# Secrets
export $(xargs < ~/.secrets)

# After each command, save and reload history
export PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"

# Golang
export GOPATH=$HOME/go
export GOROOT="$(brew --prefix golang)/libexec"
export PATH="$PATH:${GOPATH}/bin:${GOROOT}/bin"

# Postgress
export PATH="$(eval "brew --prefix")/opt/postgresql@14/bin:$PATH"
export LDFLAGS="-L$(eval "brew --prefix")/opt/postgresql@14/lib"
export CPPFLAGS="-I$(eval "brew --prefix")/opt/postgresql@14/include"
export PKG_CONFIG_PATH="$(eval "brew --prefix")/opt/postgresql@14/lib/pkgconfig"

export FZF_DEFAULT_COMMAND="fd -H -E '.git'"
export FZF_PREVIEW_ADVANCED=true
export FZF_PREVIEW_WINDOW='right:65%:nohidden'
export FZF_DEFAULT_OPTS="\
--reverse --no-info --prompt=' ' --pointer='' --marker=' ' \
--color=bg+:,bg:,spinner:#f5e0dc,hl:#f38ba8 \
--color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc \
--color=marker:#f5e0dc,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8"

# Tmux Stuff
export PATH=$HOME/.config/tmux/plugins/t-smart-tmux-session-manager/bin:$PATH

eval "$(rbenv init - zsh)"
eval "$(zoxide init zsh)"
eval "$(starship init zsh)"

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$("$HOME/.miniconda/bin/conda" 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "$HOME/.miniconda/etc/profile.d/conda.sh" ]; then
        . "$HOME/.miniconda/etc/profile.d/conda.sh"
    else
        export PATH="$HOME/.miniconda/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<
