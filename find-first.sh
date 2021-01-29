#!/usr/bin/env bash

#Simple grepper shell script to print out matches + the first problematic commit

set -eu

cmd='grep -r'
if which rg >& /dev/null; then
  cmd='rg'
fi

${cmd} "$@" 2???

#First build with the problem
BUILD=$(${cmd} -l "$@" 2??? | awk -F '/' '{print $4}' | sort -n | head -n 1)

if [[ -z "${BUILD}" ]]; then
  exit 1
fi

FAILED_BUILD_DIR=$(find * -name "$BUILD" -type d)
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
