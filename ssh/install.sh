#!/bin/sh

dirname="$(dirname "$(readlink -f "$0")")"
source "$dirname/../scripts/_shared.sh"

src="$dirname/config"
dst="$HOME/.ssh/config"
_link "$src" "$dst"

src="$dirname/ssh-agent.service"
dst="/etc/systemd/system/ssh-agent.service"
chmod 644 "$src"
_sudo_link "$src" "$dst"
_sudo_enable 'ssh-agent.service'
