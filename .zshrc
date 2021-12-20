# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

source $(brew --prefix)/opt/powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/dev/dotfiles/.p10k.zsh.
[[ ! -f ~/dev/dotfiles/.p10k.zsh ]] || source ~/dev/dotfiles/.p10k.zsh

# Download Znap, if it's not there yet.
[[ -f ~/Git/zsh-snap/znap.zsh ]] ||
    git clone --depth 1 -- \
        https://github.com/marlonrichert/zsh-snap.git ~/Git/zsh-snap

source ~/.iterm2_shell_integration.zsh
source ~/Git/zsh-snap/znap.zsh  # Start Znap

# `znap source` automatically downloads and starts your plugins.
znap source marlonrichert/zsh-autocomplete
znap source zsh-users/zsh-autosuggestions
znap source zsh-users/zsh-syntax-highlighting

# `znap eval` caches and runs any kind of command output for you.
znap eval iterm2 'curl -fsSL https://iterm2.com/shell_integration/zsh'

# `znap function` lets you lazy-load features you don't always need.
znap function _pyenv pyenvn 'eval "$( pyenv init - --no-rehash )"'
compctl -K    _pyenv pyenv

# enable commit signing
# export GPG_TTY=$TTY is faster but jetbrains does not like it
export GPG_TTY=$(tty)

# Help homebrew
export PATH="/usr/local/sbin:$PATH"

# Secrets
export $(xargs < ~/.secrets)

# what is my ip?
alias myipis='curl http://remote-ip.herokuapp.com'

alias ..='cd ..'
alias dus='du -hs'
alias df='df -h'
alias brewu='brew update;brew upgrade;brew upgrade --cask'

alias ll='ls -alGh'
alias ls='ls -Gh'
alias less='less -r'

alias ga='git add -A'
alias gb='git branch'
alias gs='git status'
alias gc='git commit -S -m'
alias gd='git diff --color'
alias gl='git log --graph --pretty=format:"%Cred%h%Creset -%C(yellow)%d%Creset %s %C(cyan)(%cr) %C(bold blue)<%an>%Creset" --abbrev-commit'
alias gce='git commit --allow-empty -m'
alias squash='git reset $(git merge-base master $(git rev-parse --abbrev-ref HEAD))'
alias dotfile='cd ~/dev/dotfiles'

alias tree='tree -C'

# History Settings
export HISTFILE=~/.zsh_history

# Increase size of file
export HISTFILESIZE=1000000000
export HISTSIZE=1000000000

# Immediate append
setopt INC_APPEND_HISTORY
export HISTTIMEFORMAT="[%F %T] "

# Handle dupplicates
setopt HIST_IGNORE_ALL_DUPS

# Java
export PATH="$(brew --prefix)/opt/openjdk/bin:$PATH"
export CPPFLAGS="-I/opt/homebrew/opt/openjdk/include"
export JAVA_HOME=$(/usr/libexec/java_home)

# Ruby
alias rbenv-doctor='curl -fsSL https://github.com/rbenv/rbenv-installer/raw/main/bin/rbenv-doctor | bash'
eval "$(rbenv init - zsh)"

# Postgress
export PATH="/opt/homebrew/opt/postgresql@11/bin:$PATH"
export LDFLAGS="-L/opt/homebrew/opt/postgresql@11/lib"
export CPPFLAGS="-I/opt/homebrew/opt/postgresql@11/include"
export PKG_CONFIG_PATH="/opt/homebrew/opt/postgresql@11/lib/pkgconfig"

# Python
export PATH="$(brew --prefix)/opt/python/libexec/bin:$PATH"
