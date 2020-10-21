#! /usr/bin/env sh

set -ex

# shellcheck disable=SC1091
. "scripts/constants.sh"

ARCHIVE_PATH="$(scripts/dist.sh)"
ARCHIVE_NAME="$(basename "${ARCHIVE_PATH}")"

HOST_URL="${CANONICAL_URL}"
if [ -n "${GITHUB_ACTIONS}" ]; then
  HOST_URL="${GITHUB_SERVER_URL}/${GITHUB_REPOSITORY}"
elif [ -n "${GITLAB_CI}" ]; then
  HOST_URL="${CI_PROJECT_URL}"
fi

sed -i -e "s;${CANONICAL_URL};${HOST_URL};g" CHANGELOG.md

if [ -n "${GITHUB_ACTIONS}" ]; then
  printf "%s\\n" "::set-output name=changelog::$(./scripts/changelog-peek.js)"
  printf "%s\\n" "::set-output name=filename::${ARCHIVE_NAME}"
  printf "%s\\n" "::set-output name=filepath::${ARCHIVE_PATH}"
elif [ -n "${GITLAB_CI}" ]; then
  curl \
    --request POST "${CI_API_V4_URL}/projects/${CI_PROJECT_ID}/releases" \
    --header "Content-Type: application/json" \
    --header "PRIVATE-TOKEN: ${PROJECT_ACCESS_TOKEN}" \
    --data "{
      \"name\": \"snapraid-btrfs-wrapper ${CI_COMMIT_TAG}\",
      \"tag_name\": \"${CI_COMMIT_TAG}\",
      \"description\": \"$(./scripts/changelog-peek.js)\",
      \"assets\": {
        \"links\": [
          {
            \"name\": \"${ARCHIVE_NAME}\",
            \"url\": \"${CI_JOB_URL}/artifacts/raw/${ARCHIVE_PATH}?inline=false\"
          }
        ]
      }
    }"
fi
