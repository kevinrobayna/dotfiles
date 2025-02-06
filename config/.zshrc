#!/bin/sh
[ -f "$HOME/.local/share/zap/zap.zsh" ] && source "$HOME/.local/share/zap/zap.zsh"

# history
HISTFILE=~/.zsh_history

# source
plug "$HOME/.config/zsh/aliases.zsh"
plug "$HOME/.config/zsh/exports.zsh"

plug "esc/conda-zsh-completion"
plug "zsh-users/zsh-autosuggestions"
plug "hlissner/zsh-autopair"
plug "zap-zsh/supercharge"
plug "zap-zsh/vim"
plug "zap-zsh/fzf"
plug "Aloxaf/fzf-tab"
plug "zap-zsh/exa"
plug "zsh-users/zsh-syntax-highlighting"
plug "wintermi/zsh-gcloud"

# keybinds
bindkey '^ ' autosuggest-accept

# But still use emacs-style zsh bindings
# https://superuser.com/questions/403355/how-do-i-get-searching-through-my-command-history-working-with-tmux-and-zshell
bindkey -e

export PATH="$HOME/.local/bin":$PATH
# Help homebrew
export PATH="$(eval "brew --prefix")/sbin:$PATH"

export PATH="$HOME/.rd/bin:$PATH"

export PATH="${ASDF_DATA_DIR:-$HOME/.asdf}/shims:$PATH"
. ~/.asdf/plugins/java/set-java-home.zsh
. ~/.asdf/plugins/golang/set-env.zsh

