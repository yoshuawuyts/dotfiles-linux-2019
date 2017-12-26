#!/bin/bash

dirname="$(dirname "$(readlink -f "$0")")"
source "$dirname/../scripts/_shared.sh"

src="$dirname/config"
dst="$HOME/.config/i3/config"
_link "$src" "$dst"
