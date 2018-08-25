#!/bin/bash

dirname="$(dirname "$(readlink -f "$0")")"
source "$dirname/../scripts/_shared.sh"

src="$dirname/gitconfig"
dst="$HOME/.gitconfig"
_link "$src" "$dst"

src="$dirname/hooks"
dst="$HOME/.config/git/hooks"
_link "$src" "$dst"
