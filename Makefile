.PHONY:
	all
	deps
	lint

all:
	@true

deps:
	@yarn install
	@test -f ./schemas/gitlab-ci.json || (mkdir -p ./schemas && wget -O ./schemas/gitlab-ci.json https://json.schemastore.org/gitlab-ci)

lint:
	@./node_modules/.bin/markdownlint "**/*.md" --ignore node_modules
	@shellcheck src/*.sh
	@./node_modules/.bin/ajv -s ./schemas/gitlab-ci.json -d .gitlab-ci.yml
