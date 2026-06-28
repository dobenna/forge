#!/usr/bin/env bash

set -euo pipefail

source "$(dirname "${BASH_SOURCE[0]}")/../bootstrap.sh"

require_root

ROLE_NAME="Visual Studio Code"

verify_role() {
    log "Verificando configuración de ${ROLE_NAME}..."

    if [[ "$INSTALL_VSCODE" != true ]]; then
        warn "Instalación de VS Code deshabilitada en config.sh"
        exit 0
    fi
}

cleanup_role() {
    log "Limpiando repositorios previos de ${ROLE_NAME}..."

    rm -f /etc/apt/sources.list.d/vscode.list
    rm -f /etc/apt/sources.list.d/vscode.sources
    rm -f /etc/apt/sources.list.d/code.list
    rm -f /etc/apt/sources.list.d/code.sources
}

install_role() {
    log "Instalando ${ROLE_NAME}..."

    install_packages \
        ca-certificates \
        curl \
        gnupg \
        apt-transport-https

    create_keyring_dir

    download_gpg_key \
        "https://packages.microsoft.com/keys/microsoft.asc" \
        "/etc/apt/keyrings/packages.microsoft.gpg"

    create_repository \
        "/etc/apt/sources.list.d/vscode.list" \
        "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main"

    refresh_repositories

    install_packages code
}

configure_role() {
    log "No hay configuración adicional para ${ROLE_NAME}."
}

validate_role() {
    log "Validando ${ROLE_NAME}..."

    code --version
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

