# what is my ip?
alias myipis='curl http://remote-ip.herokuapp.com'

alias dus='du -hs'
alias df='df -h'

alias gba='git branch -va'
alias gc='git commit -m'
alias gd='git diff --color'
alias gt='git difftool'
alias go='git checkout'
alias gl='git log --graph --pretty=format:"%Cred%h%Creset -%C(yellow)%d%Creset %s %C(cyan)(%cr) %C(bold blue)<%an>%Creset" --abbrev-commit'
alias gp='git checkout $(git reflog | grep checkout: -m 2 | tail -n1 | cut -d " " -f 8-)'
alias gce='git commit --allow-empty -m'

alias tree='tree -C'
