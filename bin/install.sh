#!/bin/sh

dirname="$(dirname "$(readlink -f "$0")")"
source "$dirname/../scripts/_shared.sh"

for f in $dirname/*; do
  chmod +x "$f"
  extname="$(echo "$f" | tr '.' ' ' | awk '{ print $2 }')"
  [ "$extname" = 'sh' ] && continue
  dst="/usr/local/bin$(echo "$f" | sed "s|$dirname||")"
  _sudo_link "$f" "$dst"
done
