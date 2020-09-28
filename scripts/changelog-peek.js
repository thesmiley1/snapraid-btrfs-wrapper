#! /usr/bin/env node

const fs       = require('fs')
const readline = require('readline')

const main = async () => {
  const lineReader = readline.createInterface({
    input: fs.createReadStream('CHANGELOG.md'),
  })

  const lines = []

  var seenVersionHeader = false

  const versionHeaderPattern = new RegExp(
    '^### \\[?\\d+\\.\\d+\\.\\d+\\]?.* \\(\\d{4}-\\d{2}-\\d{2}\\)$',
  )

  for await (const line of lineReader) {
    if (line.match(versionHeaderPattern)) {
      if (seenVersionHeader) {
        break
      }

      seenVersionHeader = true
    }

    lines.push(line)
  }

  console.log(lines.join('\\n'))
}

main().catch((err) => {
  console.log(err)
})
