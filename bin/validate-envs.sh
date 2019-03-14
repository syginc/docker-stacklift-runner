#!/bin/bash

set -eo pipefail

if [[ -z "$2" ]] ; then
  echo "usage: $0 <archive_location> <env_dir>"
  exit 1
fi

ARCHIVE_LOCATION="$1"
ENV_DIR="$2"

/prepare-archive.sh "$ARCHIVE_LOCATION"

OUT_DIR="$(mktemp -d)"

for file in "$ENV_DIR"/*.yaml ; do
  emrichen -f "$file" -o "$OUT_DIR/$(basename "$file")" "$MODULE_DIR/config.in.yaml"
done

stacklift validate-configs -m "$MODULE_DIR" "$OUT_DIR"/*.yaml
