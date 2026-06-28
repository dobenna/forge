#!/usr/bin/env bash

set -euo pipefail

source "$(dirname "${BASH_SOURCE[0]}")/../bootstrap.sh"

require_root

ROLE_NAME="Base"

verify_role() {

    log "Verificando sistema..."

    if ! grep -q "bookworm" /etc/os-release; then
        error "Forge actualmente solo soporta Debian 12 (Bookworm)."
    fi

    if ! ping -c1 deb.debian.org >/dev/null 2>&1; then
        error "No hay conexión a Internet."
    fi

}

cleanup_role() {

    log "No hay limpieza requerida para ${ROLE_NAME}."

}

install_role() {

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

}

configure_role() {

    log "No hay configuración adicional para ${ROLE_NAME}."

}

validate_role() {

    log "Validando herramientas base..."

    git --version
    curl --version | head -1
    python3 --version
    pip3 --version
    jq --version

}

main() {

    verify_role
    cleanup_role
    install_role
    configure_role
    validate_role

    success "Rol ${ROLE_NAME} completado correctamente."

}

main "$@"

