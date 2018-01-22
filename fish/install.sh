#!/bin/sh

dirname="$(dirname "$(readlink -f "$0")")"
source "$dirname/../scripts/_shared.sh"

src="$dirname/config.fish"
dst="$HOME/.config/fish/config.fish"
_link "$src" "$dst"

src="$dirname/functions"
dst="$HOME/.config/fish/functions"
for f in $src/*; do
  _link "$f" "$dst/$(echo "$f" | sed "s|$src/||")"
done
