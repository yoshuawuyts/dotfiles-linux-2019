#!/bin/bash

################################################################################
#
#  Configure OS X paths
#
################################################################################

defaults write com.apple.screencapture location ~/Google\ Drive/Screenshots;
killall SystemUIServer;
