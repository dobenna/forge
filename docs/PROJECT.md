# Forge Project

## Project Overview

Forge is a modular Linux workstation provisioning framework designed to automate the installation, configuration and maintenance of professional Linux development environments.

The project was born from a simple idea:

> Every time a workstation is rebuilt, the same tools, configurations and optimizations are manually recreated.

Forge eliminates that repetitive work by converting workstation provisioning into a reproducible and version-controlled process.

Although the project started targeting Debian 12, its architecture is intentionally designed to support multiple Linux families through operating system abstraction layers.

---

# Mission

Provide a simple, modular and maintainable framework capable of provisioning complete Linux workstations for:

* DevOps Engineers
* Cloud Engineers
* Linux System Administrators
* Platform Engineers
* Developers
* Students learning Linux and Cloud technologies

Forge should reduce manual work while remaining transparent, easy to understand and educational.

---

# Vision

Forge is intended to become a long-term Linux workstation provisioning framework.

The objective is not simply to install software.

The objective is to define an entire workstation as code.

Everything required to recreate a workstation should be contained inside this repository.

Examples:

* Software installation
* Shell configuration
* Development tools
* Cloud CLIs
* Kubernetes tooling
* Git configuration
* Terminal customization
* Editor configuration
* Future desktop configuration

A workstation should become reproducible.

---

# Core Principles

## Simplicity

Simple solutions are preferred over clever ones.

The code should be readable even by someone learning Bash.

---

## Modularity

Every feature belongs to an independent role.

Roles should have one responsibility only.

Examples:

* Docker
* Git
* Terraform
* Kubernetes
* Terminal

---

## Reusability

Logic should never be duplicated.

Reusable code belongs in:

```
lib/
```

Configuration belongs in:

```
templates/
```

Roles should orchestrate rather than implement everything themselves.

---

## Portability

Forge should progressively support multiple Linux families.

Operating system differences should be hidden behind abstraction libraries.

Roles should describe *what* they want to achieve rather than *how* a specific distribution performs the task.

---

## Predictability

Running the same role multiple times should produce the same result whenever possible.

The framework should detect existing configurations before applying changes.

---

## Documentation

Documentation is considered part of the source code.

Architectural decisions should always be documented.

A future contributor should understand *why* something exists before modifying it.

---

# Design Philosophy

Forge is organized into independent layers.

```
Configuration
        │
Bootstrap
        │
Roles
        │
Libraries
        │
Templates
```

Each layer has a single responsibility.

This separation makes the project easier to maintain and easier to extend.

---

# Architecture Goals

The architecture should allow:

* adding new roles without affecting existing ones;
* supporting new Linux distributions;
* replacing implementation details without changing role logic;
* introducing new package managers;
* adding new templates without modifying Bash code.

---

# Distribution Strategy

Forge currently supports Debian-based systems.

The framework is already being prepared for Red Hat based systems through abstraction layers.

Current abstraction:

* Operating system detection
* Package manager abstraction

Planned abstraction:

* Repository management
* Service management
* File management
* Firewall management
* Desktop environment management

Long-term objective:

```
Role

↓

Operating System Layer

↓

Distribution Implementation
```

This architecture allows one role to work across different Linux families without modification.

---

# Git Workflow

Forge follows a simplified Git Flow.

## main

Contains stable releases only.

Every commit in main should represent a releasable version.

---

## develop

Contains active development.

New functionality is implemented and tested here before being merged into main.

---

## Releases

Every stable release receives:

* version update
* changelog update
* Git tag
* GitHub release

---

# Coding Standards

Every role follows the same lifecycle.

```
verify_role()

cleanup_role()

install_role()

configure_role()

validate_role()

main()
```

Consistency is preferred over creativity.

---

# Long-Term Roadmap

Forge is expected to evolve through several stages.

## Stage 1

Foundation

* Modular roles
* Package abstraction
* Repository abstraction
* Terminal configuration

## Stage 2

Developer Experience

* GitHub CLI
* AWS CLI
* Azure CLI
* OpenShift CLI
* K9s
* LazyDocker
* LazyGit

## Stage 3

Cross Distribution

* Debian
* Ubuntu
* Linux Mint
* Rocky Linux
* AlmaLinux
* Fedora
* RHEL

## Stage 4

Forge CLI

Instead of executing:

```
./install.sh docker
```

Users will execute:

```
forge install docker
forge verify
forge doctor
forge update
forge version
```

The framework itself becomes a command-line application.

---

# Relationship with Atlas

Forge and Atlas are complementary projects.

Forge prepares the workstation.

Atlas provisions infrastructure.

Forge focuses on the engineer's environment.

Atlas focuses on cloud infrastructure and automation.

Both projects share the same engineering principles:

* modularity;
* documentation;
* reproducibility;
* automation;
* version control.

---

# Success Criteria

Forge will be considered mature when:

* a complete workstation can be rebuilt in minutes;
* adding support for a new Linux distribution requires minimal changes;
* roles remain independent and reusable;
* documentation accurately reflects the architecture;
* every release is reproducible from Git.

---

# Final Statement

Forge is not intended to become another configuration management platform.

It is intentionally focused on one objective:

> Build, maintain and reproduce professional Linux workstations using clean architecture, automation and engineering best practices.

Every design decision should reinforce that objective.

