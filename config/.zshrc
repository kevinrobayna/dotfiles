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

export PATH="/Library/TeX/texbin:$HOME/.local/bin":$PATH
export PATH="/usr/local/texlive/2026basic/bin/universal-darwin:$PATH"
# Help homebrew
export PATH="$(eval "brew --prefix")/sbin:$PATH"

export PATH="$HOME/.rd/bin:$PATH"

source "$(brew --prefix)/share/google-cloud-sdk/path.zsh.inc"

# mise manages the language runtimes (java, node, python, ruby, go, rust).
# Last thing in the file so it wins over every PATH export above.
# Shims are for GUI apps like JetBrains that never source this file; activate
# is what interactive shells actually use.
export PATH="$HOME/.local/share/mise/shims:$PATH"
eval "$(mise activate zsh)"
