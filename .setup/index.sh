#!/bin/bash

################################################################################
#
# Load OS X configuration.
#
################################################################################

source ~/config/osx.sh

################################################################################
#
# Provision OS X.
#
################################################################################

ruby -e "$(curl -fsSL https://raw.github.com/Homebrew/homebrew/go/install)"
brew bundle ~/setup/Brewfile
brew bundle ~/setup/Caskfile
