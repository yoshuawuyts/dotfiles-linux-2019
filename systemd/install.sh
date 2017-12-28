#!/bin/sh

dirname="$(dirname "$(readlink -f "$0")")"
source "$dirname/../scripts/_shared.sh"

src="$dirname/xsecurelock@.service"
dst="/usr/lib/systemd/system/xsecurelock@.service"
chmod 644 "$src"
_sudo_link "$src" "$dst"
_sudo_enable "xsecurelock@$(whoami).service"
