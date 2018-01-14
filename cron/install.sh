#!/bin/bash

dirname="$(dirname "$(readlink -f "$0")")"
source "$dirname/../scripts/_shared.sh"

src="$dirname/crontab"
dst="/etc/crontab"
_sudo_link "$src" "$dst"

src="$dirname/low-battery.sh"
dst="/usr/bin/low-battery"
_sudo_link "$src" "$dst"
