# Go Repository Template

[![Build Status](https://github.com/golang-templates/seed/workflows/build/badge.svg)](https://github.com/golang-templates/seed/actions?query=workflow%3Abuild)
[![GoDoc](https://godoc.org/github.com/golang-templates/seed?status.svg)](https://godoc.org/github.com/golang-templates/seed)
[![GitHub Release](https://img.shields.io/github/release/golang-templates/seed.svg)](https://github.com/golang-templates/seed/releases)
[![Go Report Card](https://goreportcard.com/badge/github.com/golang-templates/seed)](https://goreportcard.com/report/github.com/golang-templates/seed)

This is a GitHub repository template for Go. It has been created for ease-of-use for anyone who wants to:

- quickly get into Go without losing too much time on environment setup,
- create a new repoisitory with basic Continous Integration.

It includes:

- [Visual Studio Code](https://code.visualstudio.com) configuration with [Go](https://code.visualstudio.com/docs/languages/go) and [Remote Container](https://code.visualstudio.com/docs/remote/containers) support,
- [modd](https://github.com/cortesi/modd) configuration,
- dependency management using [Go Modules](https://github.com/golang/go/wiki/Modules),
- linting with [GolangCI-Lint](https://github.com/golangci/golangci-lint),
- build automation via [Make](https://www.gnu.org/software/make), [Docker](https://docs.docker.com/engine), [Docker Compose](https://docs.docker.com/compose), [GitHub Actions](https://github.com/features/actions).

`Star` this repository if you find it valuable and worth maintaining.

## Usage

1. Click the `Use this template` button (alt. clone or download this repository).
1. Replace all occurences of `golang-templates/seed` to `your_org/repo_name` in all files.
1. Change [LICENSE](LICENSE) and [README.md](README.md).

### Setup Development Environment

#### Visual Studio Code - Bare-metal

1. Install [Go](https://golang.org/doc/install) and [Go extension](https://code.visualstudio.com/docs/languages/go).
1. Visual Studio Code: `View` → `Command Pallete... (F1)` → Select `Go: Install/Update Tools`.
1. See [Dockerfile](Dockerfile) for GolangCI-Lint installation command.

**Make on Windows:** Use [WSL (Windows Subsystem for Linux)](https://docs.microsoft.com/en-us/windows/wsl/install-win10) or try [Make Windows port](https://gist.github.com/evanwill/0207876c3243bbb6863e65ec5dc3f058).

#### Visual Studio Code - Development Container

1. [Setup Development inside a Container](https://code.visualstudio.com/docs/remote/containers#_getting-started).
1. Visual Studio Code inside Container: `View` → `Command Pallete... (F1)` → Select `Go: Install/Update Tools`.
1. See [Dockerfile](Dockerfile) for GolangCI-Lint installation command.

#### Visual Studio Code - SSH

1. [Setup Remote Development using SSH](https://code.visualstudio.com/docs/remote/ssh#_getting-started).
1. On remote machine: install [Go](https://golang.org/doc/install) and [Go extension](https://code.visualstudio.com/docs/languages/go).
1. Visual Studio Code: `View` → `Command Pallete... (F1)` → Select `Go: Install/Update Tools`.
1. See [Dockerfile](Dockerfile) for GolangCI-Lint installation command.

### Build

- Terminal: `make all`.
- Visual Studio Code: `Terminal` → `Run Build Task... (CTRL+ALT+B)` → Select `All`.
- Terminal: `docker-compose up --abort-on-container-exit`. This command is executed by CI build (GitHub Action workflow).
- [modd](https://github.com/cortesi/modd) would execute build on any *.go file change.

### Maintainance

1. `Watch` this repository to get notified about new releases, issues, etc.
1. Update Go and GolangCI-Lint version in [Dockerfile](Dockerfile).
1. Configure linters via [.golangci.yml](.golangci.yml).
1. Develop Make targets in [Makefile](Makefile) and assosiated tasks in [.vscode/tasks.json](.vscode/tasks.json).

Notable files:

- [devcontainer.json](.devcontainer/devcontainer.json) - Visual Studio Code Remote Container configuration
- [.github](.github/workflows/build.yml) - GitHub Action workflow (CI build)
- [.vscode](.vscode) - Visual Studio Code configuration files
- [.golangci.yml](.golangci.yml) - GolangCI-Lint configuration
- [docker-compose.yml](docker-compose.yml) - Compose file used in [CI build](.github/workflows/build.yml)
- [Dockerfile](Dockerfile) - Builder image used in [docker-compose.yml](docker-compose.yml) and [devcontainer.json](.devcontainer/devcontainer.json)
- [Makefile](Makefile) - Make targets used in [docker-compose.yml](docker-compose.yml) and [.vscode/tasks.json](.vscode/tasks.json)
- [modd.conf](modd.conf) - [modd](https://github.com/cortesi/modd) configuration file

## FAQ

### Why nothing for GoLand

The maintainer does not use GoLand. Fell free to create a pull request for [#2](https://github.com/golang-templates/seed/issues/2).

### Why GitHub Actions, not any other CI server

GitHub Actions is out-of-the-box if you are already using GitHub.
However, changing to any other CI server should be very simple, because this repository uses Docker Compose to run CI build to make the transition easy.

For [CircleCI](https://circleci.com/docs/2.0/executor-types/#using-machine) create `.circleci/config.yml` file:

```yml
version: 2.1
jobs:
  build:
    machine:
      image: ubuntu-1604:201903-01
    steps:
      - checkout
      - run: docker-compose up --abort-on-container-exit
```

## Contributing

Simply create an issue or a pull request.
