#! /usr/bin/env sh

set -eu


SNAPRAID_BTRFS_WRAPPER_VERSION="0.0.0-pre.0"
export SNAPRAID_BTRFS_WRAPPER_VERSION


main() {
  snapraid_btrfs_commands="
    check
    cleanup
    cleanup-all
    config
    create
    diff
    diff-sync
    dsync
    fix
    list
    ls
    pool
    resume
    rollback
    scrub
    shell
    snapper
    sync
    touch
    undochange
  "

  found=0
  for arg in "${@}"; do
    for command in $snapraid_btrfs_commands; do
      if [ "${arg}" = "${command}" ]; then
        found=1
        break
      fi
    done

    if [ $found -ne 0 ]; then
      break
    fi
  done

  if [ $found -ne 0 ]; then
    snapraid-btrfs "${@}"
  else
    snapraid "${@}"
  fi
}


main "${@}"
