#!/bin/bash

set -eo pipefail

if [[ -z "$1" ]] ; then
  echo "usage: $0 <group1> [<group2> ...]"
  exit 1
fi

pipenv sync --dev

for GROUP in "$@" ; do
  echo "Deploy $GROUP"
  pipenv run stacklift deploy-group -f "$CONFIG_FILE" -g "$GROUP"
done
