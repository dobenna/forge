#!/usr/bin/env bash

set -euo pipefail

source "$(dirname "${BASH_SOURCE[0]}")/../bootstrap.sh"

require_root

ROLE_NAME="GitHub CLI"

verify_role() {
    log "Verificando configuración de ${ROLE_NAME}..."

    if ! command_exists git; then
        error "Git no está instalado. Ejecuta primero el rol git/base."
    fi
}

cleanup_role() {
    log "No hay limpieza requerida para ${ROLE_NAME}."
}

install_role() {
    log "Instalando ${ROLE_NAME}..."

    case "$OS_FAMILY" in
        debian)
            pkg_install curl ca-certificates gnupg

            create_keyring_dir

            download_gpg_key \
                "https://cli.github.com/packages/githubcli-archive-keyring.gpg" \
                "/etc/apt/keyrings/githubcli-archive-keyring.gpg"

            create_repository \
                "/etc/apt/sources.list.d/github-cli.list" \
                "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main"

            pkg_update
            pkg_install gh
            ;;

        redhat)
            pkg_install dnf-plugins-core || true

            dnf config-manager --add-repo https://cli.github.com/packages/rpm/gh-cli.repo

            pkg_install gh
            ;;

        *)
            error "Familia de sistema no soportada para ${ROLE_NAME}: $OS_FAMILY"
            ;;
    esac
}

configure_role() {
    log "No hay configuración automática para ${ROLE_NAME}."
    warn "La autenticación se realiza manualmente con: gh auth login"
}

validate_role() {
    log "Validando ${ROLE_NAME}..."

    gh --version
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

