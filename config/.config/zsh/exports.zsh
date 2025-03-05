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
export GIT_EDITOR="nvim"

# Secrets
export $(xargs < ~/.secrets)

# After each command, save and reload history
export PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"

# npm
export PATH="$PATH:$(npm config get prefix)/bin"

# Java
export GRADLE_USER_HOME="$HOME/.gradle"
export JAVA_OPTS="-Xmx8192m"

# Golang
export GOPRIVATE=$PRIVATE_SCM

# Ruby
export DISABLE_SPRING=true
export RUBY_CONFIGURE_OPTS="--enable-yjit"
export RUBY_YJIT_ENABLE=1

# Postgress
export PATH="$(eval "brew --prefix")/opt/postgresql@16/bin:$PATH"
export LDFLAGS="-L$(eval "brew --prefix")/opt/postgresql@16/lib"
export CPPFLAGS="-I$(eval "brew --prefix")/opt/postgresql@16/include"
export PKG_CONFIG_PATH="$(eval "brew --prefix")/opt/postgresql@16/lib/pkgconfig"

export FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS \
  --highlight-line \
  --info=inline-right \
  --ansi \
  --layout=reverse \
  --border=none
  --color=bg+:#2d3f76 \
  --color=bg:#1e2030 \
  --color=border:#589ed7 \
  --color=fg:#c8d3f5 \
  --color=gutter:#1e2030 \
  --color=header:#ff966c \
  --color=hl+:#65bcff \
  --color=hl:#65bcff \
  --color=info:#545c7e \
  --color=marker:#ff007c \
  --color=pointer:#ff007c \
  --color=prompt:#65bcff \
  --color=query:#c8d3f5:regular \
  --color=scrollbar:#589ed7 \
  --color=separator:#ff966c \
  --color=spinner:#ff007c \
"
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

# Kubernetes Stuff
export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"

# AWS Stuff
export AWS_VAULT_KEYCHAIN_NAME="login"
export AWS_SESSION_TTL="12h"

# Configure Colima as Docker Host for applications which don't respect Docker Contexts
# Testcontainers should use the default Docker Socket
# Testcontainers should use the Colima VM instance local address as host
export DOCKER_HOST=unix://${HOME}/.colima/default/docker.sock
export TESTCONTAINERS_DOCKER_SOCKET_OVERRIDE=/var/run/docker.sock
export TESTCONTAINERS_HOST_OVERRIDE=$(colima ls -j | jq -r '.address // ""')

eval "$(rbenv init - --no-rehash)"
eval "$(zoxide init zsh)"
eval "$(starship init zsh)"
source <(fzf --zsh)

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

source "$(brew --prefix)/share/google-cloud-sdk/path.zsh.inc"
source "$(brew --prefix)/share/google-cloud-sdk/completion.zsh.inc"
