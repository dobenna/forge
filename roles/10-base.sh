#!/usr/bin/env bash

set -euo pipefail

source "$(dirname "${BASH_SOURCE[0]}")/../bootstrap.sh"

require_root

log "Actualizando repositorios..."

apt_update

log "Instalando paquetes base..."

install_packages \
    ca-certificates \
    curl \
    wget \
    gnupg \
    lsb-release \
    apt-transport-https \
    software-properties-common \
    build-essential \
    git \
    nano \
    vim \
    unzip \
    zip \
    tree \
    htop \
    btop \
    tmux \
    rsync \
    jq \
    yq \
    ripgrep \
    fd-find \
    bat \
    fzf \
    dnsutils \
    net-tools \
    nmap \
    tcpdump \
    lsof \
    strace \
    python3 \
    python3-pip \
    python3-venv \
    python3-dev \
    openssh-client \
    openssh-server \
    sudo

success "Base instalada correctamente."
