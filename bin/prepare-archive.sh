#!/bin/bash

set -eo pipefail

if [[ -z "$1" ]] ; then
  echo "usage: $0 <archive_location>"
  exit 1
fi

ARCHIVE_LOCATION="$1"

cd "$ARCHIVE_DIR"

if [[ -e .stacklift.ready ]] ; then
    exit 0
fi

if [[ "$ARCHIVE_LOCATION" == s3://* ]] ; then
  aws s3 cp "$ARCHIVE_LOCATION" - | tar xz
else
  tar xzf "$ARCHIVE_LOCATION"
fi

pipenv sync --dev

touch .stacklift.ready
