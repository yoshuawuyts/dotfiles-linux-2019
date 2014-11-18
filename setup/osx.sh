#!/bin/bash

configure_keyboard() {
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
