#!/usr/bin/env bash
# macOS preferences. Run once on a new Mac; some changes need a logout to apply.

set -euo pipefail
[ "$(uname -s)" = Darwin ] || { echo "defaults.sh: macOS only" >&2; exit 1; }

# Expand save and print panels by default
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint -bool true

# Fastest key repeat that System Settings allows
defaults write NSGlobalDomain KeyRepeat -int 2
defaults write NSGlobalDomain InitialKeyRepeat -int 15

# Tap to click on the trackpad
defaults write com.apple.AppleMultitouchTrackpad Clicking -bool true
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true

# Finder: no .DS_Store on network or USB volumes, no extension change warning
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false
chflags nohidden ~/Library

# Dock: show indicators for open apps
defaults write com.apple.dock show-process-indicators -bool true

for app in Finder Dock SystemUIServer; do
  killall "$app" >/dev/null 2>&1 || true
done
