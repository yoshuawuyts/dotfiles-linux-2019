#!/bin/bash

dirname="$(dirname "$(readlink -f "$0")")"
source "$dirname/../scripts/_shared.sh"

src="$dirname/bashrc"
dst="$HOME/.bashrc"

_link "$src" "$dst"
