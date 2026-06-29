# Forge Roadmap

This document describes the planned evolution of Forge.

The roadmap is intentionally ambitious. Features may move between releases as the project evolves.

---

# Version 0.2.0

## Foundation Release

Completed

* Modular role architecture
* Bootstrap framework
* Configuration system
* Bash libraries
* Package abstraction
* Operating system detection
* Docker role
* Kubernetes role
* Terraform role
* VS Code role
* Chrome role
* Terminal role
* Verify role
* Root terminal configuration
* Documentation
* Git workflow
* Semantic versioning

---

# Version 0.3.0

## Cross Distribution

Objectives

* Complete package abstraction
* Repository abstraction
* Service abstraction
* File abstraction
* Debian improvements
* Ubuntu validation
* Rocky Linux support
* AlmaLinux support
* Fedora validation
* RHEL validation

New roles

* AWS CLI
* Azure CLI
* GitHub CLI
* OpenShift CLI
* K9s
* LazyDocker
* LazyGit
* Tailscale

---

# Version 0.4.0

## Forge CLI

Replace install.sh with a real command line application.

Example

forge install docker
forge install terminal
forge verify
forge doctor
forge update
forge version

Objectives

* CLI parser
* Better help
* Better logging
* Interactive mode
* Dry-run mode

---

# Version 0.5.0

## Plugins

Objectives

* Custom roles
* Plugin discovery
* External repositories
* Community plugins

---

# Version 0.6.0

## Testing

Objectives

* Unit tests
* Integration tests
* Virtual machine testing
* Multi-distribution validation

---

# Version 0.7.0

## CI/CD

Objectives

* GitHub Actions
* Automatic testing
* Automatic releases
* ShellCheck
* Markdown linting

---

# Version 0.8.0

## Desktop Experience

Configuration templates

* VS Code
* Git
* SSH
* Tmux
* Vim
* Fonts
* Wallpapers
* Icons

---

# Version 0.9.0

## Enterprise Features

* Inventory support
* Profiles
* Multiple users
* Logging improvements
* Backup and restore

---

# Version 1.0.0

## Stable Release

Objectives

* Complete documentation
* Stable architecture
* Multi-distribution support
* Automated testing
* Public release
* Long-term maintenance

---

# Long-Term Vision

Forge should become a complete Linux workstation provisioning framework capable of building reproducible development environments with minimal manual intervention.

The project should remain:

* Modular
* Portable
* Documented
* Reproducible
* Maintainable

