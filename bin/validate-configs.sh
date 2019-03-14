#!/bin/bash

set -eo pipefail

if [[ -z "$2" ]] ; then
  echo "usage: $0 <archive_location> <config_dir>"
  exit 1
fi

ARCHIVE_LOCATION="$1"
CONFIG_DIR="$2"

/prepare-archive.sh "$ARCHIVE_LOCATION"

stacklift validate-configs -m "$MODULE_DIR" "$CONFIG_DIR"/*.yaml
