# Forge Roadmap

Forge is a long-term Linux workstation provisioning framework.

The roadmap reflects the planned evolution of the project while keeping the architecture modular, portable and maintainable.

---

# Current Status

Current Version

```text
0.2.0
```

Project Status

Foundation Completed

The core architecture has been established and the framework is now ready to evolve incrementally through real-world usage.

---

# Version 0.3.0

## Atlas Preparation

Objective

Prepare Forge to become the provisioning foundation for Project Atlas.

### New Roles

* GitHub CLI
* AWS CLI
* Ansible
* OpenShift CLI

### Improvements

* Repository abstraction
* Package abstraction improvements
* Red Hat family support
* Documentation improvements

Status

* GitHub CLI ✅
* AWS CLI ⏳
* Ansible ⏳
* OpenShift CLI ⏳

---

# Version 0.4.0

## Cross Distribution

Objective

Transform Forge into a true cross-distribution provisioning framework.

### Supported Platforms

Current

* Debian 12

Validation

* Ubuntu
* Linux Mint

New Support

* Rocky Linux
* AlmaLinux
* Fedora
* Red Hat Enterprise Linux

### Architecture

* Repository abstraction
* Service abstraction
* File abstraction
* Package mapping
* Distribution validation

---

# Version 0.5.0

## Developer Experience

Objective

Provide a complete developer workstation.

### New Roles

* K9s
* LazyDocker
* LazyGit
* Tailscale
* GitHub CLI Extensions

### Templates

* VS Code
* Git
* SSH
* Tmux
* Vim

---

# Version 0.6.0

## Forge CLI

Objective

Transform Forge into a complete command-line application.

Current

```text
./install.sh docker
```

Future

```text
forge install docker

forge install kubernetes

forge install terminal

forge verify

forge doctor

forge update

forge version
```

### Features

* CLI parser
* Interactive mode
* Better logging
* Dry-run mode
* Configuration validation

---

# Version 0.7.0

## Plugin System

Objective

Allow external modules to extend Forge.

### Features

* Plugin discovery
* External repositories
* Community roles
* Custom templates

---

# Version 0.8.0

## Testing

Objective

Automate quality assurance.

### Features

* Unit tests
* Integration tests
* Multi-distribution testing
* Virtual machine testing
* Container testing

---

# Version 0.9.0

## CI/CD

Objective

Automate the development lifecycle.

### Features

* GitHub Actions
* ShellCheck
* Markdown linting
* Automatic releases
* Automatic tagging
* Documentation validation

---

# Version 1.0.0

## Stable Release

Forge reaches production quality.

### Goals

* Stable architecture
* Complete documentation
* Cross-distribution support
* Automated testing
* CI/CD pipeline
* Public release
* Long-term maintenance

---

# Completed Milestones

## Version 0.2.0

Foundation Phase

Completed

* Modular architecture
* Bootstrap framework
* Configuration system
* Role lifecycle
* Bash libraries
* Template system
* Git workflow
* Semantic versioning
* Documentation
* Operating system detection
* Package abstraction
* Docker role
* Kubernetes role
* Terraform role
* VS Code role
* Chrome role
* Git role
* Terminal role
* Verify role
* Root terminal configuration

---

# Long-Term Vision

Forge is intended to become a complete Linux workstation provisioning framework.

Future workstations should be reproducible from a single repository with minimal manual intervention.

The framework will continue evolving according to the following principles:

* Simplicity
* Modularity
* Portability
* Reproducibility
* Documentation
* Automation

---

# Relationship with Atlas

Forge provisions the workstation.

Atlas provisions the infrastructure.

Forge prepares the engineer.

Atlas automates the platform.

Both projects evolve independently while sharing the same engineering principles and architectural philosophy.

