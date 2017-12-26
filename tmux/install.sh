#!/bin/bash

dirname="$(dirname "$(readlink -f "$0")")"
source "$dirname/../scripts/_shared.sh"

src="$dirname/tmux.conf"
dst="$HOME/.tmux.conf"

_link "$src" "$dst"
