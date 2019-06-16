#!/bin/bash

dirname="$(dirname "$(readlink -f "$0")")"
source "$dirname/../scripts/_shared.sh"

mkdir -p "$HOME/.zsh/functions"

# dir="/usr/share/plugins/zsh"
# mkdir -p "$dir"
# pushd "$dir"
# pwd
# sudo git clone git@github.com:zdhrarma/fast-syntax-highlighting.git
# sudo git clone git@github.com:zdhrarma/history-search-multi-word
# sudo git clone git@github.com:zsh-users/zsh-autosuggestions
# popd

src="$dirname/zshrc"
dst="$HOME/.zshrc"
_link "$src" "$dst"

src="$dirname/co"
dst="$HOME/.zsh/functions/co"
_link "$src" "$dst"

src="$dirname/_c"
dst="$HOME/.zsh/functions/_co"
_link "$src" "$dst"
