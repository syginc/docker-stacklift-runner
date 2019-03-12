#!/bin/bash

set -eo pipefail

if [[ -z "$4" ]] ; then
  echo "usage: $0 <archive_location> <env_file> <s3_path> <project_name> [<codebuild_param> ...]"
  exit 1
fi

ARCHIVE_LOCATION="$1"
ENV_FILE="$2"
S3_PATH="$3"
PROJECT_NAME="$4"

/prepare-archive.sh "$ARCHIVE_LOCATION"
/prepare-config.sh "$ENV_FILE"

zip -r - . | aws s3 cp - "$S3_PATH"

aws codebuild start-build --project-name "$PROJECT_NAME" ${@:5}
