#!/bin/bash

dirname="$(dirname "$(readlink -f "$0")")"
source "$dirname/../scripts/_shared.sh"

src="$dirname/Xresources"
dst="$HOME/.Xresources"
_link "$src" "$dst"

src="$dirname/xinitrc"
dst="$HOME/.xinitrc"
_link "$src" "$dst"

src="$dirname/xserverrc"
dst="$HOME/.xserverrc"
_link "$src" "$dst"

src="$dirname/xsession"
dst="$HOME/.xsession"
_link "$src" "$dst"
