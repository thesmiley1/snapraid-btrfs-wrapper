#! /usr/bin/env sh

set -ex

# shellcheck disable=SC1091
. "scripts/constants.sh"

BIN_NAME="snapraid-btrfs-wrapper"

BIN_SOURCE_PATH="src/snapraid-btrfs-wrapper.sh"

DIST_DIR="dist"

LABEL="v${VERSION}"
if [ -n "${GITHUB_ACTIONS}" ]; then
  LABEL="${GITHUB_REF}"
elif [ -n "${GITLAB_CI}" ]; then
  LABEL="${CI_COMMIT_TAG}"
elif [ -z "${RELEASE}" ]; then
  if [ -d .git ] || git rev-parse --git-dir > /dev/null 2>&1; then
    LABEL="${LABEL}-git-$(git rev-parse --verify "HEAD^{commit}")"
  fi

  LABEL="${LABEL}-build-$(date "+%s.%Y-%m-%d.%H-%M-%S")"
fi

LABEL_DIR="${BIN_NAME}-${LABEL}"

BIN_DIR="${DIST_DIR}/${LABEL_DIR}/bin"

mkdir -p "${BIN_DIR}"

cp "${BIN_SOURCE_PATH}" "${BIN_DIR}/${BIN_NAME}"

ARCHIVE_PATH="${DIST_DIR}/${LABEL_DIR}.tar.xz"

tar c -f - -C "${DIST_DIR}" "${LABEL_DIR}/" | xz -9 - > "${ARCHIVE_PATH}"

printf "%s\\n" "${ARCHIVE_PATH}"
