#! /usr/bin/env sh

set -eux

test -d schemas || mkdir schemas
test -f schemas/gitlab-ci.json || wget -O schemas/gitlab-ci.json https://json.schemastore.org/gitlab-ci
test -f schemas/package.json || wget -O schemas/package.json https://json.schemastore.org/package

shellcheck scripts/*.sh src/*.sh

yamllint --config-file .yamllint.yml .

yarn run ajv -s schemas/gitlab-ci.json -d .gitlab-ci.yml

yarn run ajv -s schemas/package.json -d package.json

yarn run commitlint --from "v0.0.0-pre.0"

yarn run eslint --ignore-pattern "!.*" .

yarn run markdownlint "**/*.md" --ignore node_modules --ignore CHANGELOG.md
