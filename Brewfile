# CLI tools live in config/.config/mise/config.toml. Homebrew is for what mise
# can't manage: zsh/bash/tmux, services, libraries, compilers, casks and fonts.

# Packages from the third-party taps below must be trusted before Homebrew will
# load them; the `homebrew` mise task does that before running `brew bundle`.
tap "kevinrobayna/tap"
tap "peonping/tap"
tap "localstack/tap"
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
# Cross-platform file change monitor
brew "fswatch"
# Modern ls replacement
brew "eza"
# Terminal handling library (terminfo, tput)
brew "ncurses"
# Resource monitor TUI (aqua has no macOS build)
brew "btop"
# System info printer (neofetch successor); aqua expects the binary at the
# archive root but the macOS release ships it under usr/bin
brew "fastfetch"

#NVim Stuff
# Code search tool (ag)
brew "the_silver_searcher"
# GNU sed (gsed)
brew "gnu-sed"
# Lua package manager
brew "luarocks"
# Image conversion/manipulation tools
brew "imagemagick"
# Minimal TeX Live distribution
cask "basictex"
# the `extras` mise task builds the nvim perl provider with these; system perl lacks headers
# Perl 5 interpreter
brew "perl"
# Lightweight CPAN module installer
brew "cpanminus"
# HTTP/FTP file downloader
brew "wget" # used by mason

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
# Automatic git commit --fixup
brew "git-absorb"
# Interactive process viewer
brew "htop"
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
# Sound effects and desktop notifications for AI coding agents
brew "peonping/tap/peon-ping"

# AWS / Google / Etc
# Google Cloud SDK (gcloud, gsutil, bq)
cask "gcloud-cli"
# Store AWS credentials in the macOS Keychain
brew "aws-vault"
# LocalStack (local AWS emulator) CLI, plus `awslocal`, the aws CLI pointed at it
brew "localstack/tap/localstack-cli"
brew "awscli-local"

# Web Development
# Installer/updater for JetBrains IDEs
cask "jetbrains-toolbox"
# Container runtime VM for Docker on macOS
brew "colima"
# Docker CLI
brew "docker"
# Docker BuildKit build plugin
brew "docker-buildx"
# Multi-container orchestration plugin
brew "docker-compose"
# Keeps registry logins (e.g. Kamal's ghcr.io token) in the macOS Keychain
brew "docker-credential-helper"
# Docker logins for Amazon ECR registries
brew "docker-credential-helper-ecr"
# JVM build tool (Kotlin/Java projects)
brew "gradle"

# Ruby / Postgres
# ruby-build needs autoconf to compile ruby (mise config sets ruby.compile)
# Generates configure scripts for building from source
brew "autoconf"
# Unicode/i18n library
brew "icu4c"
# YAML parser (ruby's psych links against it; without it ruby-lsp/bundler crash)
brew "libyaml"
# Library metadata lookup used when compiling ruby and native gems
brew "pkgconf"
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
# Menu bar organizer
cask "bartender"
# Clipboard history manager
cask "clipy"
# Keep the Mac awake
cask "caffeine"
# Arc web browser
cask "arc"
# Markdown knowledge base / notes
cask "obsidian"
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
# Code editor
cask "visual-studio-code"
# Messaging
cask "telegram"
# Pair programming / screen sharing
cask "pop-app"
# Expose local servers through public tunnels
cask "ngrok"
# VM environments from a Vagrantfile
cask "vagrant"
# Install and manage web apps as Firefox PWAs
brew "firefoxpwa"
# Games
cask "steam"

# Elgato webcam settings
cask "elgato-camera-hub"
# Elgato Key Light / accessory control
cask "elgato-control-center"

# Blu-ray playback (keys and MakeMKV are set up by the private vlc repo's install.sh;
# Homebrew disabled the makemkv cask)
# Media player
cask "vlc"
# Blu-ray player app
cask "blu-ray-player"
# AACS decryption library VLC loads for Blu-rays
brew "libaacs"
# BD+ decryption library VLC loads for Blu-rays
brew "libbdplus"
# Video transcoder (shrinks MakeMKV rips)
cask "handbrake-app"
# HandBrakeCLI, for batch-converting rips
brew "handbrake"
# Media server for ripped discs
cask "jellyfin"

# Apple Store Stuff
mas "The Unarchiver", id: 425424353
mas "Unsplash Wallpapers", id: 1284863847
mas "Sleeve for Spotify, Music", id: 1606145041
mas "Dynamic Wallpaper Engine", id: 1453504509
mas "1Password for Safari", id: 1569813296
