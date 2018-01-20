#!/bin/bash

dirname="$(dirname "$(readlink -f "$0")")"
source "$dirname/../scripts/_shared.sh"

src="$dirname/vimrc"
dst="$HOME/.vimrc"

_link "$src" "$dst"

if [ ! -d ~/.vim/autoload/vim-plug ]; then
  curl -sfLo ~/.vim/autoload/plug.vim \
  --create-dirs \
  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  vim +PluginInstall +qall
  pushd ~/.vim/plugged/completor.vim
  npm install -g tern
  make js
  popd
  npm install -g prettier_standard
fi
