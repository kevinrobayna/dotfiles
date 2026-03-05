# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

Personal dotfiles for macOS. Configs are managed with GNU Stow and symlinked into `$HOME` via `install.sh`.

## Setup Commands

```bash
./install.sh link       # Symlink configs into $HOME (uses stow)
./install.sh homebrew   # Install Homebrew packages from Brewfile
./install.sh shell      # Set zsh as default shell
./install.sh macos      # Apply macOS defaults
./install.sh tmux       # Install tmux plugin manager (tpm)
./install.sh all        # Run all of the above
```

## Architecture

### Symlink Strategy (GNU Stow)

Three stow packages are used in `install.sh`:
- `config/` - stowed to `$HOME` (contains `.config/` subtree: nvim, zsh, tmux, git, alacritty, bat, btop, htop, lf, starship)
- `gitconfig/` - stowed to `$HOME` with `--dotfiles` flag (files prefixed `dot-` become `.` files)
- `claude/` - stowed to `$HOME` with `--dotfiles` flag (Claude Code config at `dot-claude/`)

Manual symlinks (not stow-managed):
- `lazygit/config.yml` → `~/Library/Application Support/jesseduffield/lazygit/config.yml`
- `lazydocker/config.yml` → `~/Library/Application Support/jesseduffield/lazydocker/config.yml`
- `ghostty/config` → `~/Library/Application Support/com.mitchellh.ghostty/config`

### Key Directories

- `config/.config/nvim/` - Neovim config using LazyVim. Entry point: `init.lua` → `lua/config/lazy.lua`. Plugins in `lua/plugins/`.
- `config/.config/zsh/` - Shell config: `exports.zsh` (env vars, tool inits) and `aliases.zsh`
- `config/.config/tmux/tmux.conf` - Tmux configuration
- `config/.config/git/` - Git config (hooks, attributes, ignore patterns)
- `bin/` - Custom scripts: `gwt` (git worktree helper), `gwt-rm`, `tmux-sessionizer`
- `blink/` - Blink Shell (iOS) theme
- `Brewfile` - All Homebrew dependencies

### Neovim

Uses LazyVim framework with plugins organized by concern in `lua/plugins/`:
- `lang.lua` - Language-specific plugins (treesitter, LSP configs)
- `ui.lua` - UI customization (theme, statusline)
- `git.lua` - Git integration
- `settings.lua` - Editor behavior overrides
- `disabled.lua` - Explicitly disabled LazyVim defaults

Formatting: Lua files use `stylua` (config in `stylua.toml`).

### Claude Code Config

The `claude/dot-claude/` directory gets stowed to `~/.claude/` and contains:
- `CLAUDE.md` - Global instructions applied to all projects
- `skills/` - Custom skill definitions (commit, create-pr, update-pr, pr-feedback, ci-errors, github)
