#!/bin/bash

dirname="$(dirname "$(readlink -f "$0")")"
source "$dirname/../scripts/_shared.sh"

src="$dirname/gtkrc-2.0"
dst="$HOME/.gtkrc-2.0"
_link "$src" "$dst"

src="$dirname/gtk-3.0-settings.ini"
dst="$HOME/.config/gtk-3.0/settings.ini"
_link "$src" "$dst"
