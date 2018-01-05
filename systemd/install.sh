#!/bin/sh

dirname="$(dirname "$(readlink -f "$0")")"
source "$dirname/../scripts/_shared.sh"

src="$dirname/xsecurelock@.service"
dst="/usr/lib/systemd/system/xsecurelock@.service"
chmod 644 "$src"
_sudo_link "$src" "$dst"
_sudo_enable "xsecurelock@$(whoami).service"

# Allow retrieving lat,long
sudo systemctl enable gpsd
sudo systemctl start gpsd

# Enable power management
sudo systemctl enable tlp.service
sudo systemctl start tlp.service
sudo systemctl enable tlp-sleep.service
sudo systemctl start tlp-sleep.service
