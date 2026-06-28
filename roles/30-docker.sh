#!/usr/bin/env bash

set -euo pipefail

source "$(dirname "${BASH_SOURCE[0]}")/../bootstrap.sh"

require_root

ROLE_NAME="Docker"

verify_role() {

    log "Verificando configuración de ${ROLE_NAME}..."

    if [[ "$INSTALL_DOCKER" != true ]]; then
        warn "Instalación de Docker deshabilitada en config.sh"
        exit 0
    fi

    if ! id "$USER_NAME" >/dev/null 2>&1; then
        error "El usuario $USER_NAME no existe."
    fi
}

cleanup_role() {

    log "Limpiando paquetes Docker antiguos..."

    remove_packages \
        docker.io \
        docker-compose \
        docker-doc \
        podman-docker \
        containerd \
        runc

}

install_role() {

    log "Instalando ${ROLE_NAME}..."

    install_packages \
        ca-certificates \
        curl \
        gnupg

    create_keyring_dir

    download_gpg_key \
        "https://download.docker.com/linux/debian/gpg" \
        "/etc/apt/keyrings/docker.gpg"

    create_repository \
        "/etc/apt/sources.list.d/docker.list" \
        "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian bookworm stable"

    refresh_repositories

    install_packages \
        docker-ce \
        docker-ce-cli \
        containerd.io \
        docker-buildx-plugin \
        docker-compose-plugin

}

configure_role() {

    log "Configurando ${ROLE_NAME}..."

    enable_service docker

    if id -nG "$USER_NAME" | grep -qw docker; then
        log "El usuario $USER_NAME ya pertenece al grupo docker."
    else
        usermod -aG docker "$USER_NAME"
        warn "El usuario debe cerrar sesión y volver a entrar para usar Docker sin sudo."
    fi

}

validate_role() {

    log "Validando ${ROLE_NAME}..."

    docker --version
    docker compose version

    if systemctl is-active --quiet docker; then
        success "Servicio Docker activo."
    else
        error "El servicio Docker no está activo."
    fi

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
