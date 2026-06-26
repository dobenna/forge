#!/usr/bin/env bash
#
# Legolas Bootstrap Configuration
#

#######################################
# Usuario
#######################################

USER_NAME="dobe"

#######################################
# Git
#######################################

GIT_NAME="Elba Guerra"
GIT_EMAIL="dobenna@gmail.com"
GIT_DEFAULT_BRANCH="main"

#######################################
# Sistema
#######################################

TIMEZONE="America/Santiago"
DEFAULT_EDITOR="vim"

#######################################
# Instalación de componentes
#######################################

INSTALL_DOCKER=true
INSTALL_PODMAN=true
INSTALL_KUBERNETES=true
INSTALL_TERRAFORM=true
INSTALL_VSCODE=true
INSTALL_CHROME=true
INSTALL_ZSH=true

#######################################
# Docker
#######################################

DOCKER_ENABLE_SERVICE=true
DOCKER_ADD_USER_TO_GROUP=true

#######################################
# Kubernetes
#######################################

KUBECTL_VERSION="stable"
KIND_VERSION="v0.29.0"

#######################################
# Terraform
#######################################

TERRAFORM_CHANNEL="stable"

#######################################
# Colores del Bootstrap
#######################################

COLOR_INFO="BLUE"
COLOR_WARN="YELLOW"
COLOR_SUCCESS="GREEN"
COLOR_ERROR="RED"
