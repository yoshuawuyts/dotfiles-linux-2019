#!/bin/bash

dirname="$(dirname "$(readlink -f "$0")")"

dirs="$(ls "$dirname/../")"
echo "$dirs"
