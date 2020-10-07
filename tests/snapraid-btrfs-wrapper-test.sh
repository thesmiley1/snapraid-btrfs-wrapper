#! /usr/bin/env bash

# Bash is used here for compatibility with Ubuntu.  Seemingly dash on Ubuntu
# does not support $LINENO, even though it is POSIX standard and support was
# apparently added upstream in 2009.  Something doesn't seem right here, but I
# did not pin down definitively why this is happening.
#
# * <https://github.com/koalaman/shellcheck/issues/644>

set -eu


assert_equal() {
  if [ "${2}" != "${3}" ]; then
    printf "Expected \`%s\` to equal \`%s\`\\n" "${1}" "${2}"
    printf "Got \`%s\` instead\\n" "${3}"
    printf "Line %s\\n" "${4}"
    exit 1
  fi
}


setup() {
  _ORIG_PATH="${PATH}"
  PATH="${PWD}/tests/fixtures/bin:${PATH}"
}

teardown() {
  PATH="${_ORIG_PATH}"
}


test_argument_passing() {
  SNAPRAID_BTRFS_WRAPPER_TEST_ARGUMENTS="1"
  export SNAPRAID_BTRFS_WRAPPER_TEST_ARGUMENTS

  for arg in diff sync scrub; do
    out="$(./src/snapraid-btrfs-wrapper.sh "${arg}" "foo" "bar")"
    expected="$(printf "%s\\n%s\\n%s\\n" "${arg}" "foo" "bar")"
    assert_equal "arguments" "${expected}" "${out}" "${LINENO}"
  done

  for arg in smart up down; do
    out="$(./src/snapraid-btrfs-wrapper.sh "${arg}" "foo" "bar")"
    expected="$(printf "%s\\n%s\\n%s\\n" "${arg}" "foo" "bar")"
    assert_equal "arguments" "${expected}" "${out}" "${LINENO}"
  done

  unset SNAPRAID_BTRFS_WRAPPER_TEST_ARGUMENTS
}

test_command_search() {
  SNAPRAID_BTRFS_WRAPPER_TEST_COMMAND="1"
  export SNAPRAID_BTRFS_WRAPPER_TEST_COMMAND

  for arg in diff sync scrub; do
    out="$(./src/snapraid-btrfs-wrapper.sh "${arg}")"
    assert_equal "program" "snapraid-btrfs" "${out}" "${LINENO}"
  done

  for arg in smart up down; do
    out="$(./src/snapraid-btrfs-wrapper.sh "${arg}")"
    assert_equal "program" "snapraid" "${out}" "${LINENO}"
  done

  unset SNAPRAID_BTRFS_WRAPPER_TEST_COMMAND
}


test_all() {
  test_argument_passing
  test_command_search
}


main() {
  printf "%s\\n" "Testing snapraid-btrfs-wrapper..."

  setup
  test_all
  teardown

  printf "%s\\n" "...all tests passed."
}


main "${@}"
