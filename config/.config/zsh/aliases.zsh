alias nf="fastfetch"
alias lg="lazygit"
alias ld="lazydocker"

# Create tmux session for dev folders, also cd into them, similar to autojump
alias t="~/dev/dotfiles/bin/tmux-sessionizer"
# Close all tmux sessions except current
alias tc="tmux kill-session -a"

alias v="nvim"
alias vi="nvim"
alias vim="nvim"

alias ..='cd ..'
alias dus='du -hs'
alias df='df -h'
alias brewu='brew update;brew upgrade;brew upgrade --cask;brew cleanup'

alias less='less -r'

alias gl='git log --graph --pretty=format:"%Cred%h%Creset -%C(yellow)%d%Creset %s %C(cyan)(%cr) %C(bold blue)<%an>%Creset" --abbrev-commit'
alias gce='git commit --allow-empty -m'
alias squash='git reset $(git merge-base master $(git rev-parse --abbrev-ref HEAD))'
alias squashm='git reset $(git merge-base main $(git rev-parse --abbrev-ref HEAD))'

alias :GoToFile="nvim +GoToFile"
alias :GoToCommand="nvim +GoToCommand"

alias catf='bat'
alias bathelp='bat --plain --language=help'
help() {
    "$@" --help 2>&1 | bathelp
}

alias rbenv-doctor='curl -fsSL https://github.com/rbenv/rbenv-installer/raw/main/bin/rbenv-doctor | bash'
alias be='bundle exec'
alias rcode='bundle exec rubocop --autocorrect --display-style-guide --extra-details --display-cop-names --parallel'

alias up='docker-compose up -d --remove-orphans'
alias down='docker-compose down -v --remove-orphans'

alias kubectx="kubectl-ctx"
alias kubens="kubectl-ns"
