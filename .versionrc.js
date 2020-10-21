// https://github.com/conventional-changelog/standard-version#can-i-use-standard-version-for-additional-metadata-files-languages-or-version-files

const versionRegex = /VERSION="(\d+\.\d+\.\d+.*)"/

const updater = {
  readVersion: (contents) => {
    return contents.match(versionRegex)[1]
  },

  writeVersion: (contents, version) => {
    return contents.replace(versionRegex, `VERSION="${version}"`)
  },
}

const constants = {
  filename: 'scripts/constants.sh',
  updater: updater,
}

const wrapper = {
  filename: 'src/snapraid-btrfs-wrapper.sh',
  updater: updater,
}

module.exports = {
  bumpFiles: [constants, wrapper],
  packageFiles: [constants],
}
