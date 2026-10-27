#!/bin/sh
[ -f "$HOME/.local/share/zap/zap.zsh" ] && source "$HOME/.local/share/zap/zap.zsh"

# history
HISTFILE=~/.zsh_history

# mise manages runtimes and CLI tools, and exports.zsh runs some of them
# (zoxide, starship, fzf), so activate first. Its precmd hook re-prepends the
# mise paths on every prompt, so the PATH exports below can't shadow them.
eval "$(mise activate zsh)"

# source
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

# after plugins so our aliases override theirs
plug "$HOME/.config/zsh/aliases.zsh"

# keybinds
bindkey '^ ' autosuggest-accept

# But still use emacs-style zsh bindings
# https://superuser.com/questions/403355/how-do-i-get-searching-through-my-command-history-working-with-tmux-and-zshell
bindkey -e

export PATH="/Library/TeX/texbin:$HOME/.local/bin":$PATH
export PATH="/usr/local/texlive/2026basic/bin/universal-darwin:$PATH"
# Help homebrew
export PATH="$HOMEBREW_PREFIX/sbin:$PATH"

export PATH="$HOME/.rd/bin:$PATH"

# Work-only config (aliases, functions, env) that never goes in this repo.
# Like ~/.secrets, created by hand on the work laptop. Last so it overrides everything.
[ -f "$HOME/.zshrc.work" ] && source "$HOME/.zshrc.work"
