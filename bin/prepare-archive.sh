#!/bin/bash

set -eo pipefail

if [[ -z "$2" ]] ; then
  echo "usage: $0 <archive_location> <env_file>"
  exit 1
fi

ARCHIVE_LOCATION="$1"
ENV_PATH=$(realpath "$2")

if [[ "$ARCHIVE_LOCATION" == s3://* ]] ; then
  aws s3 cp "$ARCHIVE_LOCATION" - | tar xz
else
  cp -pr "$ARCHIVE_LOCATION/." .
fi

pipenv sync --dev
pipenv run emrichen -f "$ENV_PATH" -o "$CONFIG_FILE" "$CONFIG_IN_FILE"
pipenv run stacklift validate-configs -m . "$CONFIG_FILE"
