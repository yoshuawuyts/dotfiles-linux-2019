#!/bin/sh

dirname="$(dirname "$(readlink -f "$0")")"
source "$dirname/../scripts/_shared.sh"

src="$dirname/workrave@.service"
dst="/etc/systemd/system/workrave@.service"

chmod 644 "$src"
_sudo_link "$src" "$dst"
_sudo_enable "workrave@$(whoami).service"
