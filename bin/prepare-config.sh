#!/bin/bash

set -eo pipefail

if [[ -z "$1" ]] ; then
  echo "usage: $0 <env_path>"
  exit 1
fi

ENV_PATH="$(realpath "$1")"

cd "$MODULE_DIR"

cp "$ENV_PATH" env.yaml
emrichen --include-env -f env.yaml -o config.yaml config.in.yaml
stacklift validate-configs -m . config.yaml
