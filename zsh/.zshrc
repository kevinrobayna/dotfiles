# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

source $(brew --prefix)/opt/powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/dev/dotfiles/.p10k.zsh.
[[ ! -f ~/dev/dotfiles/.p10k.zsh ]] || source ~/dev/dotfiles/.p10k.zsh

# Autojump config https://github.com/wting/autojump
[ -f `brew --prefix autojump`/etc/profile.d/autojump.sh ] && . `brew --prefix autojump`/etc/profile.d/autojump.sh

# Download Znap, if it's not there yet.
[[ -f ~/Git/zsh-snap/znap.zsh ]] ||
    git clone --depth 1 -- \
        https://github.com/marlonrichert/zsh-snap.git ~/Git/zsh-snap

source ~/Git/zsh-snap/znap.zsh  # Start Znap

# `znap source` automatically downloads and starts your plugins.
znap source marlonrichert/zsh-autocomplete
znap source zsh-users/zsh-autosuggestions
znap source zsh-users/zsh-syntax-highlighting

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
# But still use emacs-style zsh bindings
# https://superuser.com/questions/403355/how-do-i-get-searching-through-my-command-history-working-with-tmux-and-zshell
bindkey -e

# Secrets
export $(xargs < ~/.secrets)

alias details="neofetch"

# Create tmux session for dev folders, also cd into them, similar to autojump
alias t="~/dev/dotfiles/bin/tmux-sessionizer"
# Close all tmux sessions except current
alias tc="tmux kill-session -a"

alias vi="nvim"
alias vim="nvim"

alias ..='cd ..'
alias dus='du -hs'
alias df='df -h'
alias brewu='brew update;brew upgrade;brew upgrade --cask;brew cleanup'

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

alias catf='bat --paging=never'
alias bathelp='bat --plain --language=help'
help() {
    "$@" --help 2>&1 | bathelp
}

# History Settings
export HISTFILE=~/.zsh_history

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


# Handle dupplicates
setopt HIST_IGNORE_ALL_DUPS

# Ruby
eval "$(rbenv init - zsh)"
alias rbenv-doctor='curl -fsSL https://github.com/rbenv/rbenv-installer/raw/main/bin/rbenv-doctor | bash'
alias be='bundle exec'
alias rubocop='bundle exec rubocop -A --display-style-guide --extra-details --display-cop-names'

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
source $(brew --prefix)/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
