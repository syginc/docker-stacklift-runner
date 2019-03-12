#!/bin/bash

set -eo pipefail

if [[ -z "$3" ]] ; then
  echo "usage: $0 <archive_location> <env_file> <group1> [<group2> ...]"
  exit 1
fi

ARCHIVE_LOCATION="$1"
ENV_FILE="$2"

/prepare-archive.sh "$ARCHIVE_LOCATION"
/prepare-config.sh "$ENV_FILE"

/deploy.sh ${@:3}
