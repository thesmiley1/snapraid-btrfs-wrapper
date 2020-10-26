// https://github.com/conventional-changelog/standard-version#can-i-use-standard-version-for-additional-metadata-files-languages-or-version-files

const tagRegex = /--from "v(\d+\.\d+\.\d+.*)"/

const tagUpdater = {
  readVersion: (contents) => {
    return contents.match(tagRegex)[1]
  },

  writeVersion: (contents, version) => {
    return contents.replace(tagRegex, `--from "v${version}"`)
  },
}

const versionRegex = /VERSION="(\d+\.\d+\.\d+.*)"/

const versionUpdater = {
  readVersion: (contents) => {
    return contents.match(versionRegex)[1]
  },

  writeVersion: (contents, version) => {
    return contents.replace(versionRegex, `VERSION="${version}"`)
  },
}

const constants = {
  filename: 'scripts/constants.sh',
  updater: versionUpdater,
}

const lint = {
  filename: 'scripts/lint.sh',
  updater: tagUpdater,
}

const wrapper = {
  filename: 'src/snapraid-btrfs-wrapper.sh',
  updater: versionUpdater,
}


module.exports = {
  bumpFiles: [constants, lint, wrapper],
  packageFiles: [constants],
}
