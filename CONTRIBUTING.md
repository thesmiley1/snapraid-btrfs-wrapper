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
  - [Releasing](#releasing)
    - [GitLab](#gitlab)
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
- [ESLint][eslint-home]
  - [.eslintrc.js][this-eslintrc]
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


### Releasing

The project is configured to use [`standard-version`][standard-version-home], a
somewhat higher-level program from
[conventional-changelog][conventional-changelog-org-home] and friends.  Use
`make release` to run it with the correct default parameters.  This will create
a new commit and a new tag, both of which need to be pushed to the remote
repository.  Pushing the tag should cause the CI setup to do its thing and
generate a release using the project host's API.


#### GitLab

In order for [releases][gitlab-releases] to be to be created automatically on
GitLab hosts, a [project access token][gitlab-project-access-tokens] must be
created with `api` scope, and a [variable][gitlab-variables] named
`PROJECT_ACCESS_TOKEN` must be created to hold the token value.  If project
access tokens are not enabled on the GitLab instance, a [personal access
token][gitlab-personal-access-tokens] can be used instead.  Note that if using a
personal access token, it is important to use a bot account with minimal
privileges to minimize potential security fallout should the token be exposed.
This is similar to what happens when a project access token is created.  To
prevent exposure, the variable should be both masked and protected.  To be
compatible with a protected variable, [protected tags][gitlab-protected-tags]
must be configured (recommended to use wildcard `v*`).


## FAQ

- Why is there so much static analysis for just a simple shell script?
  - I wanted to use this project as an opportunity to experiment with what it
    would take to lint/validate as much as possibe in a single project, as well
    as to use that as an opportunity to take a deep dive into the configuration
    of the static analysis programs.  This got so far as commitlint, which has a
    configuration file in javascript.  ESLint's configuration is fairly
    enormous, so it stopped there.
- Why is there so much CI/CD automation for just a simple shell script?
  - See above.  I wanted to take a deeper dive into the subject and used this
    project to experiment.

<!-- Links -------------------------------------------------------------------->

<!-- Local --------------------------->

[this-commitlint-config]:
commitlint.config.js
"commitlint.config.js"

[this-eslintrc]:
.eslintrc.js
".eslintrc.js"

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

[conventional-changelog-org-home]:
https://github.com/conventional-changelog?type=source
"conventional-changelog"

[eslint-home]:
https://eslint.org/
"ESLint - Pluggable JavaScript linter"

[git-docs-githooks-commit-msg]:
https://git-scm.com/docs/githooks#_commit_msg
"Git - githooks Documentation"

[git-home]:
https://git-scm.com/
"Git"

[gitlab-personal-access-tokens]:
https://docs.gitlab.com/ee/user/profile/personal_access_tokens
"GitLab Personal access tokens"

[gitlab-project-access-tokens]:
https://docs.gitlab.com/ee/user/project/settings/project_access_tokens
"GitLab Project access tokens"

[gitlab-protected-tags]:
https://docs.gitlab.com/ee/user/project/protected_tags
"GitLab Protected tags"

[gitlab-releases]:
https://docs.gitlab.com/ee/user/project/releases/
"GitLab Releases"

[gitlab-variables]:
https://docs.gitlab.com/ee/ci/variables/
"GitLab CI/CD environment variables"

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

[standard-version-home]:
https://github.com/conventional-changelog/standard-version
"Standard Version"

[wget-home]:
https://www.gnu.org/software/wget/wget.html
"GNU Wget"

[yamllint-home]:
https://github.com/adrienverge/yamllint
"A linter for YAML files"

[yarn-home]:
https://classic.yarnpkg.com
"Yarn"
