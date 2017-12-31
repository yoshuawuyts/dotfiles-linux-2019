#!/bin/bash

dirname="$(dirname "$(readlink -f "$0")")"
source "$dirname/../scripts/_shared.sh"

src="$dirname/config"
dst="$HOME/.config/polybar/config"
_link "$src" "$dst"

src="$dirname/tmux.sh"
dst="$HOME/.config/polybar/tmux.sh"
_link "$src" "$dst"

src="$dirname/weather.sh"
dst="$HOME/.config/polybar/weather.sh"
_link "$src" "$dst"
