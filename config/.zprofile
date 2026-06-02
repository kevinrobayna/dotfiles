# .zprofile is sourced on login shells and before .zshrc. As a general rule, it should not change the
# shell environment at all.

if [[ -f /opt/homebrew/bin/brew ]]; then
    # Homebrew exists at /opt/homebrew for arm64 macos
    eval $(/opt/homebrew/bin/brew shellenv)
elif [[ -f /usr/local/bin/brew ]]; then
    # or at /usr/local for intel macos
    eval $(/usr/local/bin/brew shellenv)
elif [[ -d /home/linuxbrew/.linuxbrew ]]; then
    # or from linuxbrew
    test -d ~/.linuxbrew && eval "$(~/.linuxbrew/bin/brew shellenv)"
    test -d /home/linuxbrew/.linuxbrew && eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi

# `brew shellenv` exports FPATH, which freezes the zsh binary's version-pinned
# Cellar functions path (e.g. .../Cellar/zsh/5.9/...) into the environment.
# After `brew upgrade zsh`, long-lived processes such as the tmux server keep
# injecting the now-deleted path into new shells, so add-zsh-hook, compinit,
# is-at-least, colors, bashcompinit, etc. fail to load. The
# $(brew --prefix)/share/zsh/functions symlink always tracks the current zsh
# version, so re-add it and drop any fpath entries that no longer exist.
if (( $+commands[brew] )); then
    fpath=("$(brew --prefix)/share/zsh/functions" $fpath)
fi
fpath=(${(u)fpath})     # de-duplicate
fpath=(${^fpath}(N-/))  # keep only directories that still exist
