#!/bin/bash

set -eo pipefail

if [[ -z "$3" ]] ; then
  echo "usage: $0 <archive_location> <env_file> <group1> [<group2> ...]"
  exit 1
fi

ARCHIVE_LOCATION="$1"
ENV_PATH=$(realpath "$2")

MODULE_DIR=$(mktemp -d)

if [[ "$ARCHIVE_LOCATION" == s3://* ]] ; then
  aws s3 cp "$ARCHIVE_LOCATION" - | tar xz -C "$MODULE_DIR"
else
  cp -pr "$ARCHIVE_LOCATION/." "$MODULE_DIR"
fi

cd "$MODULE_DIR"

CONFIG_IN_FILE="${CONFIG_IN_FILE:-src/config.in.yaml}"
CONFIG_FILE="${CONFIG_IN_FILE%.in.yaml}.yaml"

export PIPENV_VENV_IN_PROJECT=true

pipenv sync --dev
pipenv run emrichen -f "$ENV_PATH" -o "$CONFIG_FILE" "$CONFIG_IN_FILE"
pipenv run stacklift validate-configs -m . "$CONFIG_FILE"

for GROUP in ${@:3}; do
  echo "Deploy $GROUP"
  pipenv run stacklift deploy-group -f "$CONFIG_FILE" -g "$GROUP"
done

rm -rf "$MODULE_DIR"
