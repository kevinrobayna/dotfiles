# Gratuitously stolen from @mathiasbynens
# https://github.com/mathiasbynens/dotfiles/blob/master/.osx

# Disable menu bar transparency
defaults write NSGlobalDomain AppleEnableMenuBarTransparency -bool false

# Show remaining battery time; hide percentage
defaults write com.apple.menuextra.battery ShowPercent -string "NO"
defaults write com.apple.menuextra.battery ShowTime -string "YES"

# Always show scrollbars
defaults write NSGlobalDomain AppleShowScrollBars -string "Always"

# Expand save panel by default
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true

# Expand print panel by default
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint -bool true

# Disable the “Are you sure you want to open this application?” dialog
defaults write com.apple.LaunchServices LSQuarantine -bool false

# Display ASCII control characters using caret notation in standard text views
# Try e.g. `cd /tmp; unidecode "\x{0000}" > cc.txt; open -e cc.txt`
defaults write NSGlobalDomain NSTextShowsControlCharacters -bool true

# Disable opening and closing window animations
defaults write NSGlobalDomain NSAutomaticWindowAnimationsEnabled -bool false

# Disable Mission Control Animations
defaults write com.apple.dock expose-animation-duration -int 0

# Increase window resize speed for Cocoa applications
defaults write NSGlobalDomain NSWindowResizeTime -float 0.001

# Disable Resume system-wide
defaults write NSGlobalDomain NSQuitAlwaysKeepsWindows -bool false

# Disable the “reopen windows when logging back in” option
# This works, although the checkbox will still appear to be checked,
# and the command needs to be entered again for every restart.
defaults write com.apple.loginwindow TALLogoutSavesState -bool false
defaults write com.apple.loginwindow LoginwindowLaunchesRelaunchApps -bool false

# Fix for the ancient UTF-8 bug in QuickLook (http://mths.be/bbo)
# Commented out, as this is known to cause problems when saving files in Adobe Illustrator CS5 :(
# echo "0x08000100:0" > ~/.CFUserTextEncoding

# Enable full keyboard access for all controls (e.g. enable Tab in modal dialogs)
defaults write NSGlobalDomain AppleKeyboardUIMode -int 3

# Enable subpixel font rendering on non-Apple LCDs
defaults write NSGlobalDomain AppleFontSmoothing -int 2

# Disable press-and-hold for keys in favor of key repeat
defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false

# Set a blazingly fast keyboard repeat rate
defaults write NSGlobalDomain KeyRepeat -int 0

# Disable auto-correct
defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false

# Enable tap to click (Trackpad) for this user and for the login screen
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1

# # Map bottom right Trackpad corner to right-click
# defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadCornerSecondaryClick -int 2
# defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadRightClick -bool true
# defaults -currentHost write NSGlobalDomain com.apple.trackpad.trackpadCornerClickBehavior -int 1
# defaults -currentHost write NSGlobalDomain com.apple.trackpad.enableSecondaryClick -bool true

# Require password immediately after sleep or screen saver begins
defaults write com.apple.screensaver askForPassword -int 1
defaults write com.apple.screensaver askForPasswordDelay -int 0

# Allow quitting Finder via ⌘ + Q; doing so will also hide desktop icons
defaults write com.apple.finder QuitMenuItem -bool true

# Disable window animations and Get Info animations in Finder
defaults write com.apple.finder DisableAllAnimations -bool true

# Show all filename extensions in Finder
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# Show status bar in Finder
defaults write com.apple.finder ShowStatusBar -bool true

# Allow text selection in Quick Look
defaults write com.apple.finder QLEnableTextSelection -bool true

# Disable disk image verification
defaults write com.apple.frameworks.diskimages skip-verify -bool true
defaults write com.apple.frameworks.diskimages skip-verify-locked -bool true
defaults write com.apple.frameworks.diskimages skip-verify-remote -bool true

# Automatically open a new Finder window when a volume is mounted
defaults write com.apple.frameworks.diskimages auto-open-ro-root -bool true
defaults write com.apple.frameworks.diskimages auto-open-rw-root -bool true
defaults write com.apple.finder OpenWindowForNewRemovableDisk -bool true

# Display full POSIX path as Finder window title
defaults write com.apple.finder _FXShowPosixPathInTitle -bool true

# Avoid creating .DS_Store files on network volumes
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true

# Disable the warning when changing a file extension
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

# Show item info below desktop icons
/usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:showItemInfo true" ~/Library/Preferences/com.apple.finder.plist

# Enable snap-to-grid for desktop icons
/usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist

# Disable the warning before emptying the Trash
defaults write com.apple.finder WarnOnEmptyTrash -bool false

# Empty Trash securely by defaw-root -bool true
defaults write com.apple.finder OpenWindowForNewRemo EFinder window title
defaults write com.apple.finder _FXShowPosixPathInTitle -bool true

# Avoid creating .DS_Store filefal true

# Avoid creating .DS_Store files on network volumes
defaults write comt lumes
defaults write com.apple.desktopservices DSDonolen changing a file extension
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

#-itensionChangeWarning -bool false

# Show item info below desktop iconlegs:IconViewSettings:showItemInfo true" ~/Library/Preferences/com.apple.finder.plist

# Enable snap-to-grid for desktop  Sist

# Enable snap-to-grid for desktop icons
/usr/libexec/PlistBuddy -c "Set :aufinder.plist

# Disable the warning before emptying the Trash
defaults write com.apple.finder WarnOnEmptyTrash -bool false

# Empty Trash securely by defaw-root ilrite com.apple.finder WarnOnEmptyTrash -bool false

# Empty Trash secutsple.finder OpenWindowForNewRemo EFinder window title
defaults write com.apple.finder _FXShowPosixPathInTitle -bool true ider _FXShowPosixPathInTitle -bool true

# Avoid creating .DS_Store filefal trueDofaults write com.apple.desktopservices DSDonolen changing a file extension
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

#-itensippon
defaults write com.apple.finder FXEnableExtensionChangeWarning -boooww item info below desktop iconlegs:IconViewSettings:showItemInfo true" ~/Library/Preferences/com.apple.finder.plist

# r Preferences/com.apple.finder.plist

# Enable snap-to-grid for desktop  Sist

# trrid for desktop  Sist

# Enable snap-to-grid for deswrt

# Disable the warning before emptying the Trash
defaults write com.apple.finder WarnOnEmptyTrash -bool friple.finder WarnOnEmptyTrash -bool false

# Empty Trash securely by defatool false

# Empty Trash secutsple.finder OpenWindowForNewRemo EFinder window title
defaults write com.apple.finder _FXDole
defaults write com.apple.finder _FXShowPosixPathInTitle -bool true ider _FXS-aitle -bool true ider _FXShowPosixPathInTitle -bool t# e com.apple.desktopservices DSDonolen changing a file extension
defaults write com.apple.finder FXEnableExtthwrite com.apple.finder FXEnableExtensionChangeWarning -bool false

#-itadxtensionChangeWarning -boooww item info below desktop iconlegs:IconViewSettings:showItemInfo true" ~/Library/Preferencee howItemInfo true" ~/Library/Preferences/com.apple.finder.plist

# r Preferencesolp  Sist

# Enable snap-to-grid for deswrt

# Disable the warning before emptying the Trash
defaults write com.apple.finder WarnOnEmptyTrash -bool friple.finder Winmptying the Trash
defaults write com.apple.finder WarnOnEmptyTrash -boohepty Trash securely by defatool false

# Empty Trash secutsple.finder OpenWindowForNewRemo EFinder window title
defaultsesrNewRemo EFinder window title
defaults write com.apple.finder _FXDole
defaults  w ider _FXShowPosixPathInTitle -bool t# e com.apple.desktopservices DSDonolen changing a file extension
defaults write com.apple.finder FXEnableExtthwrite com.appMelen changing a file extension
defaults write com.apple.finder FXEnableE.iWarning -bool false

#-itadxtensionChangeWarning -boooww item info below desktop iconlegs:IconViewSettings:showItemInforaiconlegs:IconViewSettings:showItemInfo true" ~/Library/Preferencee howItemInfo s /Preferencee howItemInfo true" ~/Library/Preferencesn le snap-to-grid for deswrt

# Disable the warning before emptying the Trash
defaults write com.apple.finderrgsh
defaults write com.apple.finder WarnOnEmptyTrash -bool friple.finder wder WarnOnEmptyTrash -boohepty Trash securely by defatool false

# Empty Trash secutsple.finder OpenWindowForNewRemo EFplcutsple.finder OpenWindowForNewRemo EFinder window title
defaultsesrNewRemo EFis
le
defaultsesrNewRemo EFinder window title
defaults  -sixPathInTitle -bool t# e com.apple.desktopservices DSDonolen changing a file extension
defaults write com.lefile extension
defaults write com.apple.finder FXEnableExtthwrite com.aisom.apple.finder FXEnableE.iWarning -bool false

#-itadxtensionChangeWarning -boooww item info below desktop iconlegs:Icilww item info below desktop iconlegs:IconViewSettings:showItemInforaiconlegs:Ico

howItemInforaiconlegs:IconViewSettings:showItemInfo onwItemInfo true" ~/Library/Preferencesn le snap-to-grid for deswrt

# Disable the warning before emptying thcable the warning before emptying the Trash
defaults write com.apple.findb
Trash -bool friple.finder wder WarnOnEmptyTrash -boohepty Trash securely by defatool false

# Empty Trash secutsple.finotool false

# Empty Trash secutsple.finder OpenWindowForNewRemo EFplcutsple.findtmrNewRemo EFplcutsple.finder OpenWindowForNewRemo EFiabewRemo EFinder window title
defaults  -sixPathInTitle -bool t# e com.apple.desktopservices DSDonolen changille.desktopservices DSDonolen changing a file extension
defaults write co f FXEnableExtthwrite com.aisom.apple.finder FXEnableE.iWarning -bool false

#-itadxtensionChangeWarning -boooww item inf
#xtensionChangeWarning -boooww item info below desktop iconlegs:Icilww item infoesiconlegs:Icilww item info below desktop iconlegs:Icol onlegs:IconViewSettings:showItemInfo onwItemInfo true" ~/Library/Preferencesn le snap-to-grid for deswrt

###############################################################################
# Screen
###############################################################################

# Require password 5 seconds after sleep or screen saver begins
defaults write com.apple.screensaver askForPassword -int 1
defaults write com.apple.screensaver askForPasswordDelay -int 5

# Save screenshots to the Pictures directory
defaults write com.apple.screencapture location -string "${HOME}/Pictures"

# Save screenshots in PNG format (other options: BMP, GIF, JPG, PDF, TIFF)
defaults write com.apple.screencapture type -string "png"

# Disable shadow in screenshots
defaults write com.apple.screencapture disable-shadow -bool true
