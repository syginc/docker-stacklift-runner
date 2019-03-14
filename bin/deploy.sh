#!/bin/bash

set -eo pipefail

if [[ -z "$2" ]] ; then
  echo "usage: $0 <config_file> <group1> [<group2> ...]"
  exit 1
fi

CONFIG_FILE="$1"

for group in ${@:2} ; do
  echo ">> Deploy $group"
  stacklift deploy-group -f "$CONFIG_FILE" -g "$group"
done
