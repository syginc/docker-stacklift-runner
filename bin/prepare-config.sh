#!/bin/bash

set -eo pipefail

if [[ -z "$1" ]] ; then
  echo "usage: $0 <env_path>"
  exit 1
fi

ENV_PATH="$1"

cd "$ARCHIVE_DIR"

pipenv run emrichen -f "$ENV_PATH" -o config.yaml config.in.yaml
pipenv run stacklift validate-configs -m . config.yaml
