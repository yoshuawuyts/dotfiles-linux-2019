#!/bin/sh

dirname="$(dirname "$(readlink -f "$0")")"
source "$dirname/../scripts/_shared.sh"

src="$dirname/fonts.conf"
dst="$HOME/.config/fontconfig/fonts.conf"

_link "$src" "$dst"
