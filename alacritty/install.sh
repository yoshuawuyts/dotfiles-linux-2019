#!/bin/bash

dirname="$(dirname "$(readlink -f "$0")")"
source "$dirname/../scripts/_shared.sh"

src="$dirname/alacritty.yml"
dst="$HOME/.config/alacritty/alacritty.yml"

_link "$src" "$dst"
