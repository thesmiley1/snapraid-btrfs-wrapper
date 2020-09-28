const readVersion = (contents) => {
  return contents.match(/# snapraid-btrfs-wrapper v(\d+\.\d+\.\d+)/)[1]
}

const wrapper = {
  filename: 'src/snapraid-btrfs-wrapper.sh',

  updater: {
    readVersion: readVersion,

    writeVersion: (contents, version) => {
      const oldVersion = readVersion(contents)

      return contents.replace(
        `# snapraid-btrfs-wrapper v${oldVersion}`,
        `# snapraid-btrfs-wrapper v${version}`,
      )
    },
  },
}

module.exports = {
  bumpFiles: [wrapper],
  packageFiles: [wrapper],
}
