#!/bin/bash

dirname="$(dirname "$(readlink -f "$0")")"
source "$dirname/../scripts/_shared.sh"

src="$dirname/vimrc"
dst="$HOME/.vimrc"
_link "$src" "$dst"

src="$dirname/spell/"
dst="$HOME/.vim"
_link "$src" "$dst"

src="$dirname/snippets/"
dst="$HOME/.vim"
_link "$src" "$dst"

if [ ! -d ~/.vim/autoload/plug.vim ]; then
  curl -sfLo ~/.vim/autoload/plug.vim \
  --create-dirs \
  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  vim +PluginInstall +qall
fi
