#!/bin/bash

if [ "$#" -lt 3 ]; then
  echo "Usage: $0 <git_repo> <branch> <parent_id> [extra arguments...]"
  echo "Missing arguments:"
  echo "  <git_repo>   : Git repository URL"
  echo "  <branch>     : Git branch"
  echo "  <job>        : Job URL"
  echo "  [extra arguments]: Any number of additional arguments"
  exit 1
fi

repo="$1"
[[ ! $repo =~ \.git$ ]] && repo="${repo}.git"

# Strip everything after '#' in https://openqa.suse.de/tests/11549040#settings
url="${3%%#*}"
# Get host with scheme stripping everything after "/t"
host="${url%%/t*}"
# Bash's basename
job="${url##*/}"
# Support https://openqa.suse.de/t13892578 URL
job="${job#t*}"

source="$host"
dest="$host"

cd "$(dirname "${BASH_SOURCE[0]}")" || exit 1

./run_clone_job.sh "$source" "$dest" "$job" "$repo" "$2" "${@:4}"
