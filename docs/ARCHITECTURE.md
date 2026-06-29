# Forge Architecture

## Introduction

This document describes the internal architecture of Forge.

Its purpose is to explain how the framework is organized, why it was designed this way and how new functionality should be implemented.

Forge is intentionally built around modularity, abstraction and reproducibility.

Every architectural decision should preserve those principles.

---

# High Level Architecture


                     User
                       │
                       ▼
                 ./install.sh
                       │
                       ▼
                 bootstrap.sh
                       │
       ┌───────────────┼────────────────┐
       │               │                │
       ▼               ▼                ▼
   config.sh       lib/*.sh      templates/*
       │
       ▼
     roles/*


The installation process flows from top to bottom.

Every layer has a single responsibility.

---

# Layer Overview

Forge is divided into five logical layers.

1. Configuration
2. Bootstrap
3. Roles
4. Libraries
5. Templates

Each layer should remain independent.

---

# Configuration Layer

File:


config.sh


Purpose:

Provide all configurable values for the framework.

Examples:

* target user
* Git configuration
* enabled features
* terminal options
* installation flags

The configuration layer should never contain logic.

---

# Bootstrap Layer

File:


bootstrap.sh


Purpose:

Initialize the Forge runtime.

Responsibilities:

* load configuration
* load libraries
* detect operating system
* validate environment
* expose shared functions

Every role imports bootstrap.

No role should directly load libraries.

---

# Role Layer

Directory:

roles/

A role represents one capability.

Examples:

* Docker
* Git
* Kubernetes
* Terraform
* Terminal

Roles should remain independent.

Every role follows the same lifecycle.


verify_role()

cleanup_role()

install_role()

configure_role()

validate_role()

main()


Each stage has a single responsibility.

---

## verify_role()

Validates prerequisites.

Examples:

* supported operating system
* existing users
* required binaries
* enabled configuration

No changes should happen here.

---

## cleanup_role()

Prepares the system.

Examples:

* remove obsolete repositories
* backup configuration
* remove conflicting files

---

## install_role()

Performs software installation.

This stage should only install software.

Configuration belongs elsewhere.

---

## configure_role()

Applies configuration.

Examples:

* copy templates
* configure Git
* enable shell
* create directories

---

## validate_role()

Confirms the installation.

Examples:

* version checks
* service status
* configuration validation

---

# Library Layer

Directory:

lib/


Libraries contain reusable functionality.

Roles should avoid implementing the same logic multiple times.

Current libraries:

* common.sh
* system.sh
* apt.sh
* repository.sh
* os.sh
* pkg.sh

Future libraries:

* files.sh
* services.sh
* git.sh
* network.sh
* terminal.sh

---

# Template Layer

Directory:

templates/

Templates contain configuration files only.

No Bash logic belongs here.

Examples:

templates/

zsh/

aliases.zsh

exports.zsh

functions.zsh

zshrc


Future templates:

VS Code

Git

SSH

Docker

Tmux

Vim

---

# Operating System Abstraction

One of the most important architectural decisions in Forge is operating system abstraction.

Roles should not depend directly on a specific Linux distribution.

Instead they interact with abstraction libraries.

Example:

Instead of:


apt install docker-ce


Roles use:


pkg_install docker-ce


The library determines how the installation is performed.

Current abstraction:


Role
 │
 ▼
pkg_install()
 │
 ├── apt
 ├── dnf
 └── yum


Future abstraction layers include:

* repositories
* services
* firewall
* files
* desktop environments

---

# Repository Abstraction

Current work is moving repository management into reusable libraries.

Goal:

Roles should request repositories.

Libraries should implement distribution-specific behavior.

Example:

repository_add docker

Instead of manually writing repository files.

---

# Package Abstraction

Current implementation supports:

Debian family

APT

Architecture prepared for:

Rocky Linux

AlmaLinux

RHEL

Fedora

---

# File Layout

forge/

assets/

docs/

examples/

lib/

roles/

templates/

screenshots/

tmp/

bootstrap.sh

config.sh

install.sh

VERSION

Each directory has one purpose.

---

# Git Strategy

Development occurs on:

develop


Stable releases live on:

main


Every release:

* updates VERSION
* updates CHANGELOG
* receives a Git tag

---

# Error Handling

Forge follows fail-fast principles.

Errors stop execution immediately.

Warnings allow execution to continue.

Roles should validate before modifying the system.

---

# Design Principles

Forge favors:

* readability
* maintainability
* modularity
* portability
* reproducibility

Short code is not necessarily better code.

Clear code is.

---

# Long-Term Architecture

The current framework is intentionally simple.

Future versions will introduce:

* Forge CLI
* Plugin system
* Distribution modules
* Automated tests
* GitHub Actions
* Release automation

The internal architecture should remain stable while capabilities continue to grow.

---

# Relationship Between Forge and Atlas

Forge provisions workstations.

Atlas provisions infrastructure.

Forge prepares the engineer.

Atlas automates the platform.

Both projects share the same architectural philosophy:

* modular design
* abstraction
* automation
* documentation
* reproducibility

This shared philosophy allows both projects to evolve independently while remaining complementary.

