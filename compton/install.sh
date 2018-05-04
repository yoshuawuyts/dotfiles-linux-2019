#!/bin/bash

dirname="$(dirname "$(readlink -f "$0")")"
source "$dirname/../scripts/_shared.sh"

src="$dirname/compton.conf"
dst="$HOME/.config/compton.conf"
_link "$src" "$dst"
