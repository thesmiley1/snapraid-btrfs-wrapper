# snapraid-btrfs-wrapper <!-- omit in toc -->

Wrap [`snapraid-btrfs`][snapraid-btrfs-github] to act as a drop-in replacement
for [`snapraid`][snapraid-home].

- [Usage](#usage)
- [FAQ](#faq)
  - [What is this?](#what-is-this)
  - [What does this accomplish?](#what-does-this-accomplish)
  - [Why does this exist?](#why-does-this-exist)


## Usage

Call `snapraid-btrfs-wrapper` the same as you would `snapraid-btrfs` or
`snapraid`.  All arguments will be passed to the appropriate program depending
on the command provided.

```sh
# Calls `snapraid-btrfs`
snapraid-btrfs-wrapper sync
```

```sh
# Calls `snapraid`
snapraid-btrfs-wrapper smart
```


## FAQ


### What is this?

This is a [thin wrapper][repo-wrapper] around `snapraid-btrfs` (and `snapraid`)
to act as a drop-in replacement for `snapraid`.


### What does this accomplish?

`snapraid-btrfs` provides custom functionality for a subset of the commands
provided by `snapraid`, but does not pass through the remaining commands.  This
wrapper solves that problem by passing commands known to be implemented by
snapraid-btrfs to snapraid-btrfs, and passing all other commands to snapraid.


### Why does this exist?

It is clearly a design decision that `snapraid-btrfs` does not pass through
unimplemented commands to `snapraid`.  The author of this script did not want to
have to remember which commands should be used by which programs, and thus
`snapraid-btrfs-wrapper` was born.


<!-------------------------------- END CONTENT -------------------------------->


<!-- Repository links --------------------------------------------------------->

[repo-wrapper]:
src/snapraid-btrfs-wrapper.sh
"snapraid-btrfs-wrapper.sh"


<!-- External links ----------------------------------------------------------->

[snapraid-btrfs-github]:
https://github.com/automorphism88/snapraid-btrfs
"automorphism88/snapraid-btrfs"

[snapraid-home]:
https://snapraid.it
"SnapRAID"
