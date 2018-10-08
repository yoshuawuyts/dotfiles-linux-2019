#!/bin/bash

dirname="$(dirname "$(readlink -f "$0")")"
source "$dirname/../scripts/_shared.sh"

src="$dirname/zshrc"
dst="$HOME/.zshrc"

_link "$src" "$dst"
