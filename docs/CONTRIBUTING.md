# Contributing

Thank you for contributing to Forge.

This document describes the coding standards and development workflow used by the project.

---

# Philosophy

Forge prioritizes:

* Readability
* Simplicity
* Modularity
* Reusability
* Documentation

Every contribution should reinforce these principles.

---

# Project Structure

roles/

Contains provisioning roles.

lib/

Contains reusable Bash libraries.

templates/

Contains configuration templates.

docs/

Contains project documentation.

---

# Role Standard

Every role must follow the standard lifecycle.

verify_role()

cleanup_role()

install_role()

configure_role()

validate_role()

main()

The execution order should never change.

---

# Libraries

Libraries should contain reusable functionality.

Avoid duplicating logic between roles.

Whenever the same code appears more than once, consider moving it into lib/.

---

# Templates

Templates contain configuration only.

No Bash logic should exist inside template files.

---

# Operating System Support

Roles should never depend directly on a package manager whenever possible.

Preferred:

pkg_install docker-ce

Avoid:

apt install docker-ce

The same principle applies to repositories, services and files.

---

# Documentation

Every architectural change should be reflected in the documentation.

At minimum update:

* README
* PROJECT
* CHANGELOG
* ROADMAP

when appropriate.

---

# Git Workflow

Development branch

develop

Stable branch

main

Typical workflow

1. Create feature
2. Test
3. Update documentation
4. Merge into main
5. Create release tag

---

# Commit Messages

Recommended prefixes

feat:
fix:
refactor:
docs:
style:
test:
chore:

Examples

feat: add terminal role

refactor: abstract package manager

docs: update architecture

fix: detect Rocky Linux

---

# Coding Style

Prefer

* small functions
* descriptive names
* early validation
* reusable libraries

Avoid

* duplicated code
* hidden side effects
* hardcoded paths
* distribution-specific logic inside roles

---

# Final Goal

Forge is intended to remain a clean, modular and educational project.

Every contribution should make the framework easier to understand, easier to maintain and easier to extend.

