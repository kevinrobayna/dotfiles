alias git=hub

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

alias h='cd'
alias d="cd ~/GoogleDrive"
alias dr="cd ~/Dropbox"
alias dl="cd ~/Downloads"
alias dt="cd ~/Desktop"
alias wt="cd ~/Workstation"

alias setsii='ssh alu4453@exthost.etsii.ull.es'
alias setsii2='ssh alu4453@exthost2.etsii.ull.es'
alias fetsii='sftp alu4453@exthost.etsii.ull.es'
alias sbanot='ssh alu4453@banot.etsii.ull.es'
alias fbanot='sftp alu4453@banot.etsii.ull.es'

alias tree='tree -C'
