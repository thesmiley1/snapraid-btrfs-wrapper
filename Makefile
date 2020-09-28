.PHONY:
	all
	deps
	lint
	release
	test

all:
	@true

deps:
	@yarn install

	@test -d ./schemas || mkdir ./schemas
	@test -f ./schemas/gitlab-ci.json || wget -O ./schemas/gitlab-ci.json https://json.schemastore.org/gitlab-ci
	@test -f ./schemas/package.json || wget -O ./schemas/package.json https://json.schemastore.org/package

lint:
	@./node_modules/.bin/ajv -s ./schemas/gitlab-ci.json -d .gitlab-ci.yml
	@./node_modules/.bin/ajv -s ./schemas/package.json -d package.json

# The magic hash here is an epoch that is the first commit from which it and all
# subsequent commits are expected to lint cleanly.
	@./node_modules/.bin/commitlint --from 851d990c7380f89ee41c7c4b3d1b1ca58f18bc13~1

	@./node_modules/.bin/eslint --ignore-pattern "!.*" .

	@./node_modules/.bin/markdownlint "**/*.md" --ignore node_modules --ignore CHANGELOG.md

	@shellcheck src/*.sh
	@yamllint .

release:
	@./node_modules/.bin/standard-version --header "## Changelog\
" --compareUrlFormat "https://gitlab.com/thesmiley1/snapraid-btrfs-wrapper/compare/{{previousTag}}...{{currentTag}}"

test:
	@./tests/snapraid-btrfs-wrapper-test.sh
