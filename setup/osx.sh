#!/bin/bash

# configure osx paths
main() {
  defaults write com.apple.screencapture location ~/Google\ Drive/Screenshots;
  killall SystemUIServer;
}

main;
