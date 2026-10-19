# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

Personal dotfiles for macOS. Configs are managed with GNU Stow and symlinked into `$HOME`; setup steps are mise file tasks in `mise-tasks/`.

## Setup Commands

```bash
mise run bootstrap   # Run every task below, in order
mise run link        # Symlink configs into $HOME (uses stow)
mise run homebrew    # Install Homebrew packages from Brewfile
mise run tools       # mise install (runtimes + CLI tools)
mise run update      # brew upgrade + mise upgrade
mise tasks           # List all tasks
```

Lint task scripts with `shellcheck mise-tasks/*`.

### mise vs Homebrew

CLI tools go in `config/.config/mise/config.toml`. The Brewfile holds only what mise can't manage: zsh/bash/tmux, stow, services, libraries/compilers, casks, fonts, and btop/fastfetch, whose aqua packages don't work on macOS (see Brewfile comments).

Sigstore is blocked on the work network, so the work laptop's untracked `~/.zshrc.work` sets `MISE_*` env vars that turn off mise's provenance checks (attestations, cosign, SLSA). Attestation failures elsewhere are a real signal, not this.

## Architecture

### Symlink Strategy (GNU Stow)

Three stow packages are used in `mise-tasks/link`:
- `config/` - stowed to `$HOME` (contains `.config/` subtree: nvim, zsh, tmux, git, bat, btop, htop, lf, starship)
- `gitconfig/` - stowed to `$HOME` with `--dotfiles` flag (files prefixed `dot-` become `.` files)
- `claude/` - stowed to `$HOME` with `--dotfiles` flag (Claude Code config at `dot-claude/`)

Manual symlinks (not stow-managed):
- `lazygit/config.yml` → `~/Library/Application Support/jesseduffield/lazygit/config.yml`
- `lazydocker/config.yml` → `~/Library/Application Support/jesseduffield/lazydocker/config.yml`
- `ghostty/config` → `~/Library/Application Support/com.mitchellh.ghostty/config`

### Key Directories

- `config/.config/nvim/` - Neovim config using LazyVim. Entry point: `init.lua` → `lua/config/lazy.lua`. Plugins in `lua/plugins/`.
- `config/.config/zsh/` - Shell config: `exports.zsh` (env vars, tool inits) and `aliases.zsh`
- `~/.zshrc.work` - Optional, untracked work-only zsh config (like `~/.secrets`), sourced last by `.zshrc` if present
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
- `skills/` - Custom skill definitions (gh-stack)
