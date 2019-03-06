#!/bin/bash

dirname="$(dirname "$(readlink -f "$0")")"
source "$dirname/../scripts/_shared.sh"

mkdir -p "$HOME/.zsh/functions"

src="$dirname/zshrc"
dst="$HOME/.zshrc"
_link "$src" "$dst"

src="$dirname/co"
dst="$HOME/.zsh/functions/co"
_link "$src" "$dst"

src="$dirname/_c"
dst="$HOME/.zsh/functions/_co"
_link "$src" "$dst"
