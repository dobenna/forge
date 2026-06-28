#!/usr/bin/env bash

set -euo pipefail

source "$(dirname "${BASH_SOURCE[0]}")/../bootstrap.sh"

require_root

ROLE_NAME="Terraform"

verify_role() {
    log "Verificando configuración de ${ROLE_NAME}..."

    if [[ "$INSTALL_TERRAFORM" != true ]]; then
        warn "Instalación de Terraform deshabilitada en config.sh"
        exit 0
    fi
}

cleanup_role() {
    log "No hay limpieza requerida para ${ROLE_NAME}."
}

install_role() {
    log "Instalando ${ROLE_NAME}..."

    install_packages \
        ca-certificates \
        curl \
        gnupg

    create_keyring_dir

    download_gpg_key \
        "https://apt.releases.hashicorp.com/gpg" \
        "/etc/apt/keyrings/hashicorp.gpg"

    create_repository \
        "/etc/apt/sources.list.d/hashicorp.list" \
        "deb [signed-by=/etc/apt/keyrings/hashicorp.gpg] https://apt.releases.hashicorp.com bookworm main"

    refresh_repositories

    install_packages terraform
}

configure_role() {
    log "No hay configuración adicional para ${ROLE_NAME}."
}

validate_role() {
    log "Validando ${ROLE_NAME}..."

    terraform version
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

