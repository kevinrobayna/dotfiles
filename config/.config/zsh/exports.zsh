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

# Java
export GRADLE_USER_HOME="$HOME/.gradle"
export JAVA_OPTS="-Xmx8192m"

# Golang
export GOPATH=$HOME/go
export GOPRIVATE=$PRIVATE_SCM

# Ruby
export DISABLE_SPRING=true
export RUBY_CONFIGURE_OPTS="--enable-yjit"
export RUBY_YJIT_ENABLE=1

# Postgress
export PATH="$HOMEBREW_PREFIX/opt/postgresql@17/bin:$PATH"
export LDFLAGS="-L$HOMEBREW_PREFIX/opt/postgresql@17/lib"
export CPPFLAGS="-I$HOMEBREW_PREFIX/opt/postgresql@17/include"
export PKG_CONFIG_PATH="$HOMEBREW_PREFIX/opt/postgresql@17/lib/pkgconfig"

export FZF_DEFAULT_COMMAND="fd -H -E '.git'"
export FZF_PREVIEW_ADVANCED=true
export FZF_PREVIEW_WINDOW='right:65%:nohidden'
export FZF_DEFAULT_OPTS="\
  --highlight-line \
  --reverse \
  --ansi \
  --info=inline-right \
  --prompt=' ' \
  --pointer='' \
  --marker=' ' \
  --layout=reverse \
  --border=none 
"

# Tmux Stuff
export PATH=$HOME/.config/tmux/plugins/t-smart-tmux-session-manager/bin:$PATH

# Kubernetes Stuff
export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"

# To fix my hack of github.com-work
export GH_HOST=github.com

# AWS Stuff
export AWS_VAULT_KEYCHAIN_NAME="login"
export AWS_SESSION_TTL="12h"

# DataDog stuff
export DD_SITE=datadoghq.eu

# Preferred model
export ANTHROPIC_MODEL="claude-opus-5-5"

# Configure Colima as Docker Host for applications which don't respect Docker Contexts
# Testcontainers should use the default Docker Socket
# Testcontainers should use the Colima VM instance local address as host
export DOCKER_HOST=unix://${HOME}/.colima/default/docker.sock
export TESTCONTAINERS_DOCKER_SOCKET_OVERRIDE=/var/run/docker.sock
# `colima ls` takes ~0.5s, so resolve the address before the first JVM build
# instead of on every shell start; retry until the VM is up. The VM only has an
# address when colima.yaml sets `network.address: true`.
_testcontainers_host_override() {
  [[ $1 == *(gradle|mvn)* ]] || return 0
  local vm address
  vm=$(colima ls -j 2>/dev/null)
  address=$(jq -r '.address // ""' <<<"$vm")
  [[ -n $address ]] && export TESTCONTAINERS_HOST_OVERRIDE=$address
  [[ $(jq -r '.status' <<<"$vm") == Running ]] && add-zsh-hook -d preexec _testcontainers_host_override
}
autoload -Uz add-zsh-hook
add-zsh-hook preexec _testcontainers_host_override

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

source "$HOMEBREW_PREFIX/share/google-cloud-sdk/path.zsh.inc"
source "$HOMEBREW_PREFIX/share/google-cloud-sdk/completion.zsh.inc"
