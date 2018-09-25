#!/bin/bash

dirname="$(dirname "$(readlink -f "$0")")"
source "$dirname/../scripts/_shared.sh"

src="$dirname/gdbinit"
dst="$HOME/.gdbinit"
_link "$src" "$dst"
