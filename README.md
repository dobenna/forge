# Forge

Forge is a modular Linux workstation provisioning framework designed for DevOps, Cloud, Automation and Software Engineering.

It provides a reproducible and version-controlled way to build professional Linux workstations across multiple Linux families.

Forge started as the bootstrap framework for **Legolas**, a Debian 12 workstation, but it is designed to evolve into a reusable provisioning toolkit.

---

## Current Version

0.2.0

Purpose

Forge exists to automate the setup of a professional Linux workstation.

Instead of manually installing tools every time a system is rebuilt, Forge provides a repeatable way to install, configure and validate a complete development environment.

## Supported Platforms

Current support:

- Debian 12 Bookworm
- Ubuntu (planned validation)
- Linux Mint (planned validation)

Architecture already prepared for:

- Rocky Linux
- AlmaLinux
- Red Hat Enterprise Linux
- Fedora

Forge detects the operating system at runtime and abstracts package management and operating system specific behavior through internal libraries.


## Forge currently includes roles for:

Role	    Description
Base	    Essential system packages and CLI utilities
Git	        Global Git configuration
Docker	    Docker CE and Docker Compose plugin
Kubernetes	kubectl, Helm and kind
Terraform	Terraform from HashiCorp repositories
VS Code	    Visual Studio Code
Chrome	    Google Chrome
Terminal	Zsh, Oh My Zsh, Powerlevel10k, plugins and aliases
Verify	    Environment validation and health checks

## Features

Modular role-based architecture
Centralized configuration
Reusable Bash libraries
Template-based configuration deployment
Idempotent role design where possible
Root and user terminal configuration
Git-based project history
Versioned releases
Clear project documentation


## Project Structure

forge/
├── assets/
├── bootstrap.sh
├── config.sh
├── docs/
│   ├── CHANGELOG.md
│   ├── CONTRIBUTING.md
│   ├── PROJECT.md
│   ├── README.md
│   └── ROADMAP.md
├── examples/
├── install.sh
├── lib/
│   ├── apt.sh
│   ├── common.sh
│   ├── repository.sh
│   └── system.sh
├── LICENSE
├── log/
├── README.md
├── roles/
│   ├── 10-base.sh
│   ├── 20-git.sh
│   ├── 30-docker.sh
│   ├── 40-kubernetes.sh
│   ├── 50-terraform.sh
│   ├── 60-vscode.sh
│   ├── 70-chrome.sh
│   ├── 80-terminal.sh
│   └── 90-verify.sh
├── screenshots/
├── templates/
│   ├── role-template.sh
│   └── zsh/
│       ├── aliases.zsh
│       ├── exports.zsh
│       ├── functions.zsh
│       └── zshrc
├── tmp/
└── VERSION


## Architecture Overview

Forge follows a simple execution flow:

config.sh
   ↓
bootstrap.sh
   ↓
install.sh
   ↓
roles/
   ↓
lib/ + templates/
config.sh

## Operating System Abstraction

One of Forge's core design principles is operating system abstraction.

Provisioning roles never interact directly with package managers whenever possible.

Instead they rely on reusable libraries that detect the current operating system and execute the appropriate implementation.

Current abstraction layers include:

- Operating system detection
- Package manager abstraction

Future abstraction layers:

- Repository management
- Service management
- File management
- Firewall management

This architecture allows Forge to grow beyond Debian without requiring significant changes to existing roles.

## Stores global configuration such as:

target user
Git identity
enabled components
terminal configuration options
bootstrap.sh

## Loads the Forge runtime:

configuration
common functions
system helpers
APT helpers
repository helpers
install.sh

## Acts as the main orchestrator.

It can list roles, run one role or run all roles.

roles/

Contains independent provisioning roles.

Each role is responsible for one capability.

lib/

Contains reusable Bash functions.

templates/

Contains configuration files deployed by roles.

## Usage

List available roles
./install.sh list

Run a single role
sudo ./install.sh docker

Examples:

sudo ./install.sh base
sudo ./install.sh git
sudo ./install.sh kubernetes
sudo ./install.sh terminal
sudo ./install.sh verify

Run all roles
sudo ./install.sh all
Recommended First Run

For a new Debian 12 workstation:

sudo ./install.sh base
sudo ./install.sh git
sudo ./install.sh docker
sudo ./install.sh kubernetes
sudo ./install.sh terraform
sudo ./install.sh vscode
sudo ./install.sh chrome
sudo ./install.sh terminal
sudo ./install.sh verify

After running the terminal role, log out and log back in so the default shell change takes effect.


## Terminal Role

The terminal role configures a modern Zsh environment for both the main user and root.

It installs and configures:

Zsh
Oh My Zsh
Powerlevel10k
zsh-autosuggestions
zsh-syntax-highlighting
fzf
zoxide
DevOps aliases
helper functions
shell exports

Configuration templates live in:

templates/zsh/

User configuration is deployed to:

~/.zshrc
~/.forge/

Root configuration is deployed to:

/root/.zshrc
/root/.forge/
Role Standard

Every role should follow the official Forge role structure:

verify_role()
cleanup_role()
install_role()
configure_role()
validate_role()
main()

This keeps roles predictable, readable and maintainable.

## Current Development Flow

Forge uses two main branches:

Branch	Purpose
main	Stable releases
develop	Active development

Feature work is done in develop.
Stable versions are merged into main and tagged.

## Versioning

Forge follows semantic versioning:

MAJOR.MINOR.PATCH

Example:

0.2.0

## Version information is stored in:

VERSION
Documentation

## Additional documentation is located in:

docs/
File	            Purpose
CHANGELOG.md	    Release history
CONTRIBUTING.md	    Contribution and coding rules
PROJECT.md	        Project vision and management
ROADMAP.md	    Planned versions and future ideas

## Status

Forge is currently in early development.

Current milestone:

v0.2.0 — Developer Experience

## Main achievements:

Role architecture stabilized
All current roles standardized
Terminal role implemented
Root shell configuration added
Repository helper library added
Verification role available

## Future Direction

Planned future capabilities include:

Native Red Hat family support
Cross-distribution repositories
Operating system plugins
Distribution-specific package mapping
AWS CLI
Ansible
GitHub CLI
K9s
LazyDocker
Tailscale
OpenShift CLI
Forge command wrapper
Doctor command
Automated tests
GitHub Actions
Public release workflow

## License

This project is licensed under the MIT License.

See:

LICENSE


## Author

Elba Guerra
Linux | DevOps | Automation | Cloud | Systems Engineering


## Project Vision

Forge is more than an installation framework.

Its long-term goal is to become a cross-distribution provisioning framework capable of building professional Linux workstations in a consistent, reproducible and maintainable way.

Every architectural decision is made with portability, modularity and long-term maintainability in mind.
It is a long-term learning and automation project designed to capture, automate and document the evolution of a professional Linux DevOps workstation.

