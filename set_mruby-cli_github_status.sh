#!/bin/bash

TARGET_URL=$1
TARGETS=$2
RESULT=$3
SOURCE=$4
COMMIT_MSG=$5

SHA=""

[[ $COMMIT_MSG =~ \[MRUBY_CLI_SHA:([a-f0-9]{40})\] ]] && SHA=${BASH_REMATCH[1]}
[[ -z $SHA ]] && echo "No commit SHA has been provided into the commit message" && exit 0

STATUS_PAYLOAD=$(cat <<JSON
{
  "state": "success",
  "target_url": "${TARGET_URL}",
  "description": "The build of ${TARGETS} targets ${RESULT}",
  "context": "mruby-cli-bins/${SOURCE}"
}
JSON
)

curl -u $MRUBY_CLI_BINS_USER:$MRUBY_CLI_BINS_TOKEN -d "${STATUS_PAYLOAD}" https://api.github.com/repos/hone/mruby-cli/statuses/${SHA}
