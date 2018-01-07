#!/bin/bash

dirname="$(dirname "$(readlink -f "$0")")"
source "$dirname/../scripts/_shared.sh"

src="$dirname/config.rasi"
dst="$HOME/.config/rofi/config.rasi"

_link "$src" "$dst"
