#!/bin/bash

set -eo pipefail

if [[ -z "$1" ]] ; then
  echo "usage: $0 <archive_location>"
  exit 1
fi

ARCHIVE_LOCATION="$1"

if [[ -e "$MODULE_DIR/config.in.yaml" ]] ; then
  exit 0
fi

if [[ "$ARCHIVE_LOCATION" == s3://* ]] ; then
  aws s3 cp "$ARCHIVE_LOCATION" - | tar xzf - -C "$MODULE_DIR"
else
  tar xzf "$ARCHIVE_LOCATION" -C "$MODULE_DIR"
fi

if [[ -e "$MODULE_OVERWRITE_DIR" ]] ; then
  cp -pr "$(realpath "$MODULE_OVERWRITE_DIR")/." "$MODULE_DIR"
fi
