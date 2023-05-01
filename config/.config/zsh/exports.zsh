# enable commit signing
# export GPG_TTY=$TTY is faster but jetbrains does not like it
# export GPG_TTY=$(tty)
export GPG_TTY=$TTY

# Help homebrew
export PATH="$(eval "brew --prefix")/sbin:$PATH"
# Link Homebrew casks in `/Applications` rather than `~/Applications`
export HOMEBREW_CASK_OPTS="--appdir=/Applications"

# Use vi as the default editor
export EDITOR="nvim"

# Secrets
export $(xargs < ~/.secrets)

# Increase size of file
export HISTFILESIZE=1000000000
export HISTSIZE=1000000000

# Immediate append
setopt INC_APPEND_HISTORY
export HISTTIMEFORMAT="[%F %T] "

# avoid duplicates..
export HISTCONTROL=ignoredups:erasedups

# After each command, save and reload history
export PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"

setopt EXTENDED_HISTORY          # write the history file in the ":start:elapsed;command" format.
setopt HIST_REDUCE_BLANKS        # remove superfluous blanks before recording entry.
setopt SHARE_HISTORY             # share history between all sessions.
setopt HIST_IGNORE_ALL_DUPS      # delete old recorded entry if new entry is a duplicate.

# Handle dupplicates
setopt HIST_IGNORE_ALL_DUPS

# Ruby
eval "$(rbenv init - zsh)"

# Golang
export GOPATH=$HOME/go
export GOROOT="$(brew --prefix golang)/libexec"
export PATH="$PATH:${GOPATH}/bin:${GOROOT}/bin"

# Postgress
export PATH="$(eval "brew --prefix")/opt/postgresql@14/bin:$PATH"
export LDFLAGS="-L$(eval "brew --prefix")/opt/postgresql@14/lib"
export CPPFLAGS="-I$(eval "brew --prefix")/opt/postgresql@14/include"
export PKG_CONFIG_PATH="$(eval "brew --prefix")/opt/postgresql@14/lib/pkgconfig"

# Google
source "$(brew --prefix)/share/google-cloud-sdk/path.zsh.inc"
source "$(brew --prefix)/share/google-cloud-sdk/completion.zsh.inc"

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

eval "$(zoxide init zsh)"
eval "$(starship init zsh)"
