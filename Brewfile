# Packages from the third-party taps below must be trusted before Homebrew will
# load them; `setup_homebrew` in install.sh does that before running `brew bundle`.
tap "arl/arl"
tap "kevinrobayna/tap"
tap "datadog-labs/pack"
tap "anomalyco/tap"
# homebrew/autoupdate was deprecated and moved here
tap "domt4/autoupdate"

#To allow my to install stuff from Apple Store
# Mac App Store CLI
brew "mas"

# Font, obviously
# InconsolataGo patched with Nerd Font icons
cask "font-inconsolata-go-nerd-font"
# JetBrains Mono patched with Nerd Font icons
cask "font-jetbrains-mono-nerd-font"

# SSH from iPad
# WireGuard-based mesh VPN
cask "tailscale-app"
# Roaming, latency-tolerant SSH replacement
brew "mosh"

# Shell
# Z shell
brew "zsh"
# Extra completion definitions for zsh
brew "zsh-completions"
# Up-to-date bash (macOS ships 3.2)
brew "bash"
# Terminal multiplexer
brew "tmux"
# Symlink farm manager used to install these dotfiles
brew "stow"
# Polyglot runtime/tool version manager
brew "mise"
# Cross-platform file change monitor
brew "fswatch"
# Fuzzy finder
brew "fzf"
# Modern ls replacement
brew "eza"
# Terminal handling library (terminfo, tput)
brew "ncurses"
# System info printer (neofetch successor)
brew "fastfetch"
# Git status in the tmux status bar
brew "arl/arl/gitmux"
# Syntax-highlighting pager for git diffs
brew "git-delta"
# Cross-shell prompt
brew "starship"
# Smarter cd that learns frequent directories
brew "zoxide"
# Terminal file manager
brew "lf"
# Resource monitor TUI
brew "btop"
# Smart tmux session manager
brew "joshmedeski/sesh/sesh"
# Interactive prompts for shell scripts
brew "gum"

#NVim Stuff
# Neovim editor
brew "neovim"
# Fast recursive grep (rg)
brew "ripgrep"
# Code search tool (ag)
brew "the_silver_searcher"
# Fast, user-friendly find alternative
brew "fd"
# GNU sed (gsed)
brew "gnu-sed"
# Lua package manager
brew "luarocks"
# Tree-sitter parser generator CLI
brew "tree-sitter-cli" # nvim-treesitter builds parsers with it; mason's copy is only on PATH once mason loads
# Image conversion/manipulation tools
brew "imagemagick"
# Minimal TeX Live distribution
cask "basictex"
# setup_extras builds the nvim perl provider with these; system perl lacks headers
# Perl 5 interpreter
brew "perl"
# Lightweight CPAN module installer
brew "cpanminus"
# HTTP/FTP file downloader
brew "wget" # used by mason

# datadog-labs
# Datadog CLI
brew "datadog-labs/pack/pup"

# Generic Tools
# Fast incremental file transfer
brew "rsync"
# Lightweight DNS forwarder and DHCP server
brew "dnsmasq"
# Source code tag index generator
brew "ctags"
# GNU compiler collection
brew "gcc"
# Up-to-date git
brew "git"
# GitHub CLI
brew "gh"
# Interactive process viewer
brew "htop"
# cat clone with syntax highlighting
brew "bat"
# Cross-platform graphical process/system monitor (btm)
brew "bottom"
# Advent of Code project setup generator
brew "aoc2md"
# Count lines of code by language
brew "tokei"
# Directory listing as a tree
brew "tree"

#HotKeys!
# Lua-scriptable macOS automation
cask "hammerspoon"
# Turn Caps Lock into a Hyper key
cask "hyperkey"

# GPG
# GNU Privacy Guard
brew "gnupg"
# macOS GUI pinentry for gpg passphrases
brew "pinentry-mac"
# GPG tools for macOS (keychain, Mail integration)
cask "gpg-suite"

# AI Tools
# Claude desktop app
cask "claude"
# Claude Code CLI
cask "claude-code@latest"
# Open-source terminal AI coding agent
brew "anomalyco/tap/opencode"

# AWS / Google / Etc
# Google Cloud SDK (gcloud, gsutil, bq)
cask "gcloud-cli"

# Web Development
# Installer/updater for JetBrains IDEs
cask "jetbrains-toolbox"
# API client
cask "postman"
# Expose local servers through public tunnels
cask "ngrok"
# Container runtime VM for Docker on macOS
brew "colima"
# Docker CLI
brew "docker"
# Docker BuildKit build plugin
brew "docker-buildx"
# Multi-container orchestration plugin
brew "docker-compose"

# Ruby / Postgres
# ruby-build needs autoconf to compile ruby (mise config sets ruby.compile)
# Generates configure scripts for building from source
brew "autoconf"
# Unicode/i18n library
brew "icu4c"
# MIME type database (needed by Rails' marcel)
brew "shared-mime-info"
# PostgreSQL 17 server and client
brew "postgresql@17"
# PostgreSQL SQL formatter
brew "pgformatter"
# Run a command periodically and show output
brew "watch"
# File-watching service (used by test runners/bundlers)
brew "watchman"

# Apps
# GPU-accelerated terminal emulator
cask "ghostty"
# Apple TV aerial screensaver
cask "aerial"
# Temporarily removed due to Apple being annoying with it recording my screen
# cask "bartender"
# Clipboard history manager
cask "clipy"
# Keep the Mac awake
cask "caffeine"
# Game store and launcher
cask "steam"
# Arc web browser
cask "arc"
# Run web apps as PWAs in Firefox
brew "firefoxpwa"
# Markdown knowledge base / notes
cask "obsidian"
# Telegram messenger
cask "telegram"
# VS Code editor
cask "visual-studio-code"
# CLI for working with CODEOWNERS files
cask "codeowner"
# Installer-type cask, so brew keeps no receipt for an existing manual install.
# `brew bundle check` will report this as missing until `brew install --cask logi-options+`
# is run (which needs a reboot). Listed here as intent for a fresh machine.
# Logitech mouse/keyboard configuration
cask "logi-options+"
# Password manager
cask "1password"
# 1Password CLI (op)
cask "1password-cli"
# Next meeting in the menu bar
cask "meetingbar"

# Elgato webcam settings
cask "elgato-camera-hub"

# Blu-ray playback (keys and MakeMKV are set up by the private vlc repo's install.sh;
# Homebrew disabled the makemkv cask)
# Media player
cask "vlc"
# AACS decryption library VLC loads for Blu-rays
brew "libaacs"
# BD+ decryption library VLC loads for Blu-rays
brew "libbdplus"

# Apple Store Stuff
mas "The Unarchiver", id: 425424353
mas "Unsplash Wallpapers", id: 1284863847
mas "Sleeve for Spotify, Music", id: 1606145041
mas "Dynamic Wallpaper Engine", id: 1453504509
mas "1Password for Safari", id: 1569813296
