#!/bin/bash

set -eo pipefail

if [[ -z "$1" ]] ; then
  echo "usage: $0 <group1> [<group2> ...]"
  exit 1
fi

pipenv sync --dev

for group in "$@" ; do
  echo ">> Deploy $group"
  pipenv run stacklift deploy-group -f config.yaml -g "$group"
done
