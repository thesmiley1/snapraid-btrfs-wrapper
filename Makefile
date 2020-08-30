.PHONY:
	all
	deps
	lint

all:
	@true

deps:
	@yarn install

lint:
	@./node_modules/.bin/markdownlint "**/*.md" --ignore node_modules
	@shellcheck src/*.sh
