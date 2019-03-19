#!/bin/bash

set -eo pipefail

if [[ -z "$1" ]] ; then
  echo "usage: $0 <env_path>"
  exit 1
fi

ENV_PATH="$(realpath "$1")"

cd "$MODULE_DIR"

emrichen --include-env -f "$ENV_PATH" -o config.yaml config.in.yaml
stacklift validate-configs -m . config.yaml
