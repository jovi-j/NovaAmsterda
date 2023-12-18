#!/bin/sh
echo -ne '\033c\033]0;Nova Amsterdãs\a'
base_path="$(dirname "$(realpath "$0")")"
"$base_path/NA.x86_64" "$@"
