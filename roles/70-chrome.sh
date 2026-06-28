#!/usr/bin/env bash

set -euo pipefail

source "$(dirname "${BASH_SOURCE[0]}")/../bootstrap.sh"

require_root

ROLE_NAME="Google Chrome"

verify_role() {
    log "Verificando configuración de ${ROLE_NAME}..."

    if [[ "$INSTALL_CHROME" != true ]]; then
        warn "Instalación de Chrome deshabilitada en config.sh"
        exit 0
    fi
}

cleanup_role() {
    log "Limpiando repositorios previos de ${ROLE_NAME}..."

    rm -f /etc/apt/sources.list.d/google-chrome.list
    rm -f /etc/apt/sources.list.d/google-chrome.sources
}

install_role() {
    log "Instalando ${ROLE_NAME}..."

    install_packages \
        ca-certificates \
        curl \
        gnupg

    create_keyring_dir

    download_gpg_key \
        "https://dl.google.com/linux/linux_signing_key.pub" \
        "/etc/apt/keyrings/google-chrome.gpg"

    create_repository \
        "/etc/apt/sources.list.d/google-chrome.list" \
        "deb [arch=amd64 signed-by=/etc/apt/keyrings/google-chrome.gpg] https://dl.google.com/linux/chrome/deb/ stable main"

    refresh_repositories

    install_packages google-chrome-stable
}

configure_role() {
    log "No hay configuración adicional para ${ROLE_NAME}."
}

validate_role() {
    log "Validando ${ROLE_NAME}..."

    google-chrome --version
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

