#!/usr/bin/env bash

DOTFILES="$(pwd)"
COLOR_GRAY="\033[1;38;5;243m"
COLOR_BLUE="\033[1;34m"
COLOR_GREEN="\033[1;32m"
COLOR_RED="\033[1;31m"
COLOR_PURPLE="\033[1;35m"
COLOR_YELLOW="\033[1;33m"
COLOR_NONE="\033[0m"

title() {
  echo -e "\n${COLOR_PURPLE}$1${COLOR_NONE}"
  echo -e "${COLOR_GRAY}==============================${COLOR_NONE}\n"
}

error() {
  echo -e "${COLOR_RED}Error: ${COLOR_NONE}$1"
  exit 1
}

warning() {
  echo -e "${COLOR_YELLOW}Warning: ${COLOR_NONE}$1"
}

info() {
  echo -e "${COLOR_BLUE}Info: ${COLOR_NONE}$1"
}

success() {
  echo -e "${COLOR_GREEN}$1${COLOR_NONE}"
}

setup_symlinks() {
  title "Creating symlinks"

  stow -t $HOME config
  stow -t $HOME gitconfig --dotfiles

  mkdir -p "$HOME/Library/Application Support/jesseduffield/lazygit/"
  rm "$HOME/Library/Application Support/jesseduffield/lazygit/config.yml"
  ln -s "$PWD/lazygit/config.yml" "$HOME/Library/Application Support/jesseduffield/lazygit/config.yml"

  mkdir -p "$HOME/Library/Application Support/jesseduffield/lazydocker/"
  rm "$HOME/Library/Application Support/jesseduffield/lazydocker/config.yml"
  ln -s "$PWD/lazydocker/config.yml" "$HOME/Library/Application Support/jesseduffield/lazydocker/config.yml"

  mkdir -p "$HOME/Library/Application Support/com.mitchellh.ghostty/"
  rm "$HOME/Library/Application Support/com.mitchellh.ghostty/config"
  ln -s "$PWD/ghostty/config" "$HOME/Library/Application Support/com.mitchellh.ghostty/config"
}

setup_homebrew() {
  title "Setting up Homebrew"

  if test ! "$(command -v brew)"; then
    error "Homebrew not installed."
  fi

  if [ "$(uname)" == "Linux" ]; then
    test -d ~/.linuxbrew && eval "$(~/.linuxbrew/bin/brew shellenv)"
    test -d /home/linuxbrew/.linuxbrew && eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
    test -r ~/.bash_profile && echo "eval \$($(brew --prefix)/bin/brew shellenv)" >>~/.bash_profile
  fi

  # install brew dependencies from Brewfile
  brew bundle

  # install fzf
  echo -e
  info "Installing fzf"
  "$(brew --prefix)"/opt/fzf/install --key-bindings --completion --no-update-rc --no-bash --no-fish

  info "Installing zap-zsh"
  zsh <(curl -s https://raw.githubusercontent.com/zap-zsh/zap/master/install.zsh) --branch release-v1
}

setup_extras() {
  gem install erb-formatter
  gem install neovim
  asdf plugin-add java https://github.com/halcyon/asdf-java.git
  asdf plugin add golang https://github.com/asdf-community/asdf-golang.git
}

setup_shell() {
  title "Configuring shell"

  [[ -n "$(command -v brew)" ]] && zsh_path="$(brew --prefix)/bin/zsh" || zsh_path="$(which zsh)"
  if ! grep "$zsh_path" /etc/shells; then
    info "adding $zsh_path to /etc/shells"
    echo "$zsh_path" | sudo tee -a /etc/shells
  fi

  if [[ "$SHELL" != "$zsh_path" ]]; then
    chsh -s "$zsh_path"
    info "default shell changed to $zsh_path"
  fi
}

setup_macos() {
  title "Configuring macOS"
  if [[ "$(uname)" == "Darwin" ]]; then

    echo "Finder: show all filename extensions"
    defaults write NSGlobalDomain AppleShowAllExtensions -bool true

    echo "show hidden files by default"
    defaults write com.apple.Finder AppleShowAllFiles -bool false

    echo "only use UTF-8 in Terminal.app"
    defaults write com.apple.terminal StringEncodings -array 4

    echo "expand save dialog by default"
    defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true

    echo "show the ~/Library folder in Finder"
    chflags nohidden ~/Library

    echo "Enable full keyboard access for all controls (e.g. enable Tab in modal dialogs)"
    defaults write NSGlobalDomain AppleKeyboardUIMode -int 3

    echo "Enable subpixel font rendering on non-Apple LCDs"
    defaults write NSGlobalDomain AppleFontSmoothing -int 2

    echo "Use current directory as default search scope in Finder"
    defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"

    echo "Show Path bar in Finder"
    defaults write com.apple.finder ShowPathbar -bool true

    echo "Show Status bar in Finder"
    defaults write com.apple.finder ShowStatusBar -bool true

    echo "Disable press-and-hold for keys in favor of key repeat"
    defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false

    echo "Set a blazingly fast keyboard repeat rate"
    defaults write NSGlobalDomain KeyRepeat -int 1

    echo "Set a shorter Delay until key repeat"
    defaults write NSGlobalDomain InitialKeyRepeat -int 15

    echo "Enable tap to click (Trackpad)"
    defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true

    echo "Enable Safari’s debug menu"
    defaults write com.apple.Safari IncludeInternalDebugMenu -bool true

    echo "Require password immediately after sleep or screen saver begins"
    defaults write com.apple.screensaver askForPassword -int 1
    defaults write com.apple.screensaver askForPasswordDelay -int 0

    echo "Disable “natural” (Lion-style) scrolling"
    defaults write NSGlobalDomain com.apple.swipescrolldirection -bool false

    echo "Set the icon size of Dock items to 36 pixels"
    defaults write com.apple.dock tilesize -int 36

    echo "Ensuring screenshots are saved to the ~/Downloads folder"
    defaults write com.apple.screencapture location ~/Downloads

    echo "Hot corners"
    # Hot corners
    # Possible values:
    #  0: no-op
    #  2: Mission Control
    #  3: Show application windows
    #  4: Desktop
    #  5: Start screen saver
    #  6: Disable screen saver
    #  7: Dashboard
    # 10: Put display to sleep
    # 11: Launchpad
    # 12: Notification Center
    # Top left screen corner → Mission Control
    defaults write com.apple.dock wvous-tl-corner -int 2
    defaults write com.apple.dock wvous-tl-modifier -int 0
    # Top right screen corner → Desktop
    defaults write com.apple.dock wvous-tr-corner -int 4
    defaults write com.apple.dock wvous-tr-modifier -int 0
    # Bottom left screen corner → Start screen saver
    defaults write com.apple.dock wvous-bl-corner -int 5
    defaults write com.apple.dock wvous-bl-modifier -int 0

    echo "Use list view in all Finder windows by default"
    # Four-letter codes for the other view modes: `icnv`, `clmv`, `glyv`
    defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"

    echo "Kill affected applications"

    for app in Safari Finder Dock Mail SystemUIServer; do killall "$app" >/dev/null 2>&1; done
  else
    warning "macOS not detected. Skipping."
  fi
}

setup_tmux() {
  title "Configuring Tmux"
  if [ ! -f ~/.config/tmux/plugins/tpm/tpm ]; then
    rm -Rf ~/.config/tmux/plugins
    git clone https://github.com/tmux-plugins/tpm ~/.config/tmux/plugins/tpm
  else
    echo "Found tpm!, Skipping"
  fi
  tic -x resources/tmux.terminfo
  tic -x resources/xterm-256color-italic.terminfo
}

echo "hello=world" >>~/.secrets

case "$1" in
link)
  setup_symlinks
  ;;
homebrew)
  setup_homebrew
  ;;
shell)
  setup_shell
  ;;
terminfo)
  setup_terminfo
  ;;
macos)
  setup_macos
  ;;
tmux)
  setup_tmux
  ;;
extras)
  setup_extras
  ;;
all)
  setup_homebrew
  setup_symlinks
  setup_shell
  setup_macos
  setup_terminfo
  setup_extras
  setup_tmux
  ;;
*)
  echo -e $"\nUsage: $(basename "$0") {link|homebrew|shell|extras|tmux|terminfo|macos|all}\n"
  exit 1
  ;;
esac

echo -e
success "Done."
