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

brew bundle ~/.setup/Brewfile
brew bundle ~/.setup/Caskfile

curl -sSL https://get.rvm.io | bash -s stable
ruby -e "$(curl -fsSL https://raw.github.com/Homebrew/homebrew/go/install)"
bash < <(curl -s -S -L https://raw.githubusercontent.com/moovweb/gvm/master/binscripts/gvm-installer)
