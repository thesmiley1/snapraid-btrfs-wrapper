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
	@./node_modules/.bin/ajv -s ./schemas/gitlab-ci.json -d .gitlab-ci.yml

# The magic hash here is an epoch that is the first commit from which it and all
# subsequent commits are expected to lint cleanly.
	@./node_modules/.bin/commitlint --from 515a9d39663c5dce6149b70ecc56e64bd947c547~1

	@./node_modules/.bin/markdownlint "**/*.md" --ignore node_modules

	@shellcheck src/*.sh
	@yamllint .
