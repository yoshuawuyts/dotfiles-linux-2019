# Install command-line tools using Homebrew
# Usage: `brew bundle Brewfile`

# Make sure we’re using the latest Homebrew
update

# Upgrade any already-installed formulae
upgrade

# Install GNU core utilities (those that come with OS X are outdated)
# Don’t forget to add `$(brew --prefix coreutils)/libexec/gnubin` to `$PATH`.
install coreutils
install moreutils
install findutils

# Install wget with IRI support
install wget --enable-iri

# Install more recent versions of some OS X tools
install vim --override-system-vi
install homebrew/dupes/grep
install homebrew/dupes/screen

# Install other useful binaries
install brew-cask
install coreutils
install docker
install gettext
install go
install htop-osx
install httpie
install hub
install imagemagick --with-webp
install libtool
install lynx
install nvm
install openssl
install python
install rename
install sqlite
install wget
install zsh
install consul
install riak
install nsq

install homebrew/binary/packer
install homebrew/versions/lua52

# Remove outdated versions from the cellar
cleanup
