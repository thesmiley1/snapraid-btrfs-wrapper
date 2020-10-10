#! /usr/bin/env sh

set -eux

test -d schemas || mkdir schemas
test -f schemas/gitlab-ci.json || wget -O schemas/gitlab-ci.json https://json.schemastore.org/gitlab-ci
test -f schemas/package.json || wget -O schemas/package.json https://json.schemastore.org/package

shellcheck src/*.sh

yamllint --config-file .yamllint.yml .

yarn run ajv -s schemas/gitlab-ci.json -d .gitlab-ci.yml

yarn run ajv -s schemas/package.json -d package.json

# The magic hash here is an epoch that is the first commit from which it and all
# subsequent commits are expected to lint cleanly.
yarn run commitlint --from 851d990c7380f89ee41c7c4b3d1b1ca58f18bc13~1

yarn run eslint --ignore-pattern "!.*" .

yarn run markdownlint "**/*.md" --ignore node_modules --ignore CHANGELOG.md
