#!/usr/bin/env bash
set -euxo pipefail

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

main() {
  if ! [[ -d "$DIR/../_site/.git" ]]; then
    >&2 echo "Please clone the master branch to _site!"
    exit 1
  fi

  #docker-compose build app
  docker-compose up -d app
  docker-compose run prod grunt prod
  docker-compose exec app bin/build-resume.js
  cd "$DIR/../_site"
  git add -A
  git commit --no-verify -m "Site updated at $(date -Iseconds)"
  git push
}

main "$@"
