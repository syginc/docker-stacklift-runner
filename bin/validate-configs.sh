#!/bin/bash

set -eo pipefail

if [[ -z "$2" ]] ; then
  echo "usage: $0 <archive_location> <config_dir>"
  exit 1
fi

ARCHIVE_LOCATION="$1"
CONFIG_DIR="$(realpath "$2")"

/prepare-archive.sh "$ARCHIVE_LOCATION"

cd "$ARCHIVE_DIR"

pipenv run stacklift validate-configs -m . "$CONFIG_DIR"/*.yaml
