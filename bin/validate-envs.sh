#!/bin/bash

set -eo pipefail

if [[ -z "$2" ]] ; then
  echo "usage: $0 <archive_location> <env_dir>"
  exit 1
fi

ARCHIVE_LOCATION="$1"
ENV_DIR="${2%/}"

/prepare-archive.sh "$ARCHIVE_LOCATION"

CONFIG_DIR=$(mktemp -d)

for file in "$ENV_DIR"/*.yaml ; do
  pipenv run emrichen -f "$file" -o "$CONFIG_DIR/$(basename "$file")" "$CONFIG_IN_FILE"
done

pipenv run stacklift validate-configs -m . "$CONFIG_DIR"/*.yaml
