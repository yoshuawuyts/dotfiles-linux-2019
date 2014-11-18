#!/bin/bash

configure_keyboard() {
  # Disable press-and-hold for keys in favor of key repeat
  defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false

  # Set a blazingly fast keyboard repeat rate
  defaults write NSGlobalDomain KeyRepeat -int 0
}

configure_screenshot_location() {
  defaults write com.apple.screencapture location ~/Google\ Drive/Screenshots;
  killall SystemUIServer;
}

main() {
  configure_keyboard;
  configure_screenshot_location;
}

main;
