#!/bin/sh

dirname="$(dirname "$(readlink -f "$0")")"
source "$dirname/../scripts/_shared.sh"

src="$dirname/xsecurelock@.service"
dst="/usr/lib/systemd/system/xsecurelock@.service"
chmod 644 "$src"
_sudo_link "$src" "$dst"
_sudo_enable "xsecurelock@$(whoami).service"

# Increase the max file handle count
src="$dirname/sysctl.d/99-sysctl.conf"
dst="/etc/sysctl.d/99-sysctl.conf"
_sudo_link "$src" "$dst"
sudo sysctl --system

# power management
echo '[power] masking rfkill.service'
sudo systemctl mask systemd-rfkill.service

_sudo_enable 'gpsd'                        # Allow retrieving lat,long
_sudo_enable 'tlp.service'                 # Battery management.
_sudo_enable 'tlp-sleep.service'           # Enable battery management after idle.
_sudo_enable 'netctl-auto@wlp4s0.service'  # Enable wifi.
_sudo_enable 'netctl-sleep.service'        # Enable wifi after idle.
_sudo_enable 'cronie.service'              # Enable cron.
