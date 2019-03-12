#!/bin/bash

set -eo pipefail

if [[ -z "$1" ]] ; then
  echo "usage: $0 <env_file>"
  exit 1
fi

ENV_PATH="$1"

pipenv run emrichen -f "$ENV_PATH" -o "$CONFIG_FILE" "$CONFIG_IN_FILE"
pipenv run stacklift validate-configs -m . "$CONFIG_FILE"
