#!/usr/bin/env bash

#Simple grepper shell script to print out matches + the first problematic commit

set -eu

grep -r "$@" *

#First build with the problem
BUILD=$(grep -r "$@" * | awk -F '/' '{print $4}' | sort -n  | head -n 1)

FAILED_BUILD_DIR=$(find * -name $BUILD -type d)
FIRST_FAILURE_COMMIT=$(jq -r '.jobs[0].head_sha' $FAILED_BUILD_DIR/job.json)
echo "First failed commit: $FIRST_FAILURE_COMMIT"
OZONE_DIR=${OZONE_DIR:-$PWD/../ozone}
git --git-dir="$OZONE_DIR/.git" -P \
    log \
    --color \
    --graph \
    --pretty=format:'%ci %h %G? - %d %s <%an> <%cn>' \
    --abbrev-commit \
    -n 40 \
    $FIRST_FAILURE_COMMIT
