#!/bin/sh

_link () {
  echo "[link] $1 -> $2"
  mkdir -p "$(dirname $2)"
  [ -e "$2" ] && unlink "$2"
  ln -s "$1" "$2"
}

_sudo_link () {
  echo "[link] $1 -> $2"
  mkdir -p "$(dirname $2)"
  [ -e "$2" ] && sudo unlink "$2"
  sudo ln -s "$1" "$2"
}
  
_sudo_enable () {
  echo "[enable] $1"
  sudo systemctl enable "$1" > /dev/null
  sudo systemctl start "$1" > /dev/null
}
