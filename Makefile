.PHONY:
	all
	lint

all:
	@true

lint:
	@./node_modules/.bin/markdownlint "**/*.md" --ignore node_modules
