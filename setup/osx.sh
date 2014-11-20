#!/bin/bash

configure_keyboard() {
  # Set a blazingly fast keyboard repeat rate
  defaults write NSGlobalDomain KeyRepeat -int 0
}

configure_trackpad() {
  defaults write com.apple.AppleMultitouchTrackpad TrackpadRotate -bool true;
  defaults write com.apple.AppleMultitouchTrackpad TrackpadRightClick -bool true;
  defaults write com.apple.AppleMultitouchTrackpad TrackpadThreeFingerDrag -bool true;
  defaults write com.apple.AppleMultitouchTrackpad TrackpadFourFingerPinchGesture 2;
}

configure_screenshot_location() {
  defaults write com.apple.screencapture location ~/Google\ Drive/Screenshots;
  killall SystemUIServer;
}

configure_dock() {
  defaults write com.apple.screencapture location ~/Google\ Drive/Screenshots;
}

main() {
  configure_trackpad;
  configure_keyboard;
  configure_screenshot_location;
  configure_dock;
}

main;
