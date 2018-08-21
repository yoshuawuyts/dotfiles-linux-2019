#!/bin/bash

dirname="$(dirname "$(readlink -f "$0")")"
source "$dirname/../scripts/_shared.sh"

src="$dirname/zsh"
dst="$HOME/.zsh"

_link "$src" "$dst"
