#! /usr/bin/env sh

set -eux

# shellcheck disable=SC1091
. "scripts/constants.sh"

COMPARE_URL_FRAGMENT="/compare/{{previousTag}}...{{currentTag}}"
COMPARE_URL_FORMAT="${CANONICAL_URL}${COMPARE_URL_FRAGMENT}"

# Trailing newlines are desired here, but nothing seems to work.  It may be that
# `standard-version` is stripping whitespace at some point; perhaps it's part of
# the CLI code and more granularity could be had with the javascript API.
HEADER="## Changelog"

yarn run standard-version \
  --header "${HEADER}"    \
  --compareUrlFormat "${COMPARE_URL_FORMAT}" \
  "${@}"
