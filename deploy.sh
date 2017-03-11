#!/usr/bin/env bash
set -euxo pipefail

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

main() {
  if ! [[ -d "$DIR/_site/.git" ]]; then
    >&2 echo "Please clone the master branch to _site!"
    exit 1
  fi

  docker-compose run app grunt prod
  cd "$DIR/_site"
  git add -A
  git commit -m "Site updated at $(date -Iseconds)"
  git push
}

main "$@"
