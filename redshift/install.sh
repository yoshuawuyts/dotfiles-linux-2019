#!/bin/sh

dirname="$(dirname "$(readlink -f "$0")")"
source "$dirname/../scripts/_shared.sh"

src="$dirname/redshift.conf"
dst="$HOME/.config/redshift.conf"
_link "$src" "$dst"

src="$dirname/redshift.service"
dst="/etc/systemd/system/redshift.service"
chmod 644 "$src"
_sudo_link "$src" "$dst"
_sudo_enable 'redshift.service'
