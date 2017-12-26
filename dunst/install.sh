#!/bin/bash

dirname="$(dirname "$(readlink -f "$0")")"
source "$dirname/../scripts/_shared.sh"

src="$dirname/dunstrc"
dst="$HOME/.config/dunst/dunstrc"

_link "$src" "$dst"
