#!/bin/bash

################################################################################
#
# Load OS X configuration.
#
################################################################################

source ~/.setup/osx.sh

################################################################################
#
# Provision OS X.
#
################################################################################

ruby -e "$(curl -fsSL https://raw.github.com/Homebrew/homebrew/go/install)"
curl -sSL https://get.rvm.io | bash -s stable
bash < <(curl -s -S -L https://raw.githubusercontent.com/moovweb/gvm/master/binscripts/gvm-installer)
brew bundle ~/.setup/Brewfile
brew bundle ~/.setup/Caskfile
