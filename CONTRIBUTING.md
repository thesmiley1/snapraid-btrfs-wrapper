# Contributing <!-- omit in toc -->

All contributors are welcome!

- [Bug reports and feature requests](#bug-reports-and-feature-requests)
- [Hacking](#hacking)
  - [Development dependencies](#development-dependencies)
    - [Unmanaged dependencies](#unmanaged-dependencies)
    - [NPM dependencies](#npm-dependencies)
    - [Other dependencies](#other-dependencies)
  - [Linting](#linting)
    - [Commitlint](#commitlint)
  - [Testing](#testing)
- [FAQ](#faq)


## Bug reports and feature requests

If you would like to make a bug report or feature request, please visit the
project's official issue tracker at
<https://gitlab.com/thesmiley1/snapraid-btrfs-wrapper/-/issues>.


## Hacking

Hacking on `snapraid-btrfs-wrapper` can be done straight away without installing
any dependencies, but there are some development dependencies that provide
static analysis and some other utilities.


### Development dependencies

Development dependencies roughly fall into two categories:  unmanaged
dependencies and dependencies managed by NPM (actually yarn).  There are also a
couple of schemas.


#### Unmanaged dependencies

There are a few dependencies for development that are not managed or
version-controlled by the project.  They need to installed manually, through
your distro's package manager, etc.  These include:

- [Git][git-home]
- [Make][make-home]
- [Node.js][nodejs-home]
- [ShellCheck][shellcheck-home]
- [Wget][wget-home]
- [Yamllint][yamllint-home]
- [Yarn][yarn-home]


#### NPM dependencies

NPM dependencies can be installed with a simple `yarn install`, but it is
recommended to run `make deps` instead to also download other development
dependencies (JSON schemas, particularly).


#### Other dependencies

Other dependencies (JSON schemas, particularly) should be installed with `make
deps` and they will be downloaded to a `schemas` directory that is ignored by
git.


### Linting

Running `make lint` will run all linters.  Look at the
[`Makefile`][this-makefile] for commands for running individual linters.

Linters used include:

- [Ajv][ajv-home]
  - <https://json.schemastore.org/gitlab-ci>
  - <https://json.schemastore.org/package>
- [Commitlint][commitlint-home]
  - [commitlint.config.js][this-commitlint-config]
- [Markdownlint][markdownlint-home]
  - [.markdownlint.json][this-markdownlint-config]
- [Shellcheck][shellcheck-home]
- [Yamllint][yamllint-home]
  - [.yamllint.yml][this-yamllint-config]


#### Commitlint

Commitlint is most effectively run as a [`commit-msg` git
hook][git-docs-githooks-commit-msg].  This will automatically be configured by
[husky][husky-home] if NPM dependencies are installed by yarn (as happens when
running `make deps`).


### Testing

All test-related files live under [tests/][this-tests].  The test suite can be
run with `make test`.


## FAQ

- Why is there so much static analysis for just a simple shell script?
  - I wanted to use this project as an opportunity to experiment with what it
    would take to lint/validate as much as possibe in a single project, as well
    as to use that as an opportunity to take a deep dive into the configuration
    of the static analysis programs.  This got so far as commitlint, which has a
    configuration file in javascript.  ESLint's configuration is fairly
    enormous, so it stopped there.

<!-- Links -------------------------------------------------------------------->

<!-- Local --------------------------->

[this-commitlint-config]:
commitlint.config.js
"commitlint.config.js"

[this-makefile]:
Makefile
"Makefile"

[this-markdownlint-config]:
.markdownlint.json
".markdownlint.json"

[this-tests]:
tests/
"tests/"

[this-yamllint-config]:
.yamllint.yml
".yamllint.yml"

<!-- External ------------------------>

[ajv-home]:
https://ajv.js.org/
"Ajv: Another JSON Schema Validator"

[commitlint-home]:
https://commitlint.js.org/
"Lint commit messages"

[git-docs-githooks-commit-msg]:
https://git-scm.com/docs/githooks#_commit_msg
"Git - githooks Documentation"

[git-home]:
https://git-scm.com/
"Git"

[make-home]:
https://www.gnu.org/software/make/
"GNU Make"

[markdownlint-home]:
https://github.com/DavidAnson/markdownlint
"Style checker and lint tool for Markdown"

[nodejs-home]:
https://nodejs.org
"Node.js"

[shellcheck-home]:
https://www.shellcheck.net
"ShellCheck"

[wget-home]:
https://www.gnu.org/software/wget/wget.html
"GNU Wget"

[yamllint-home]:
https://github.com/adrienverge/yamllint
"A linter for YAML files"

[yarn-home]:
https://classic.yarnpkg.com
"Yarn"
