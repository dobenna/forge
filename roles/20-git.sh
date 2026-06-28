#!/usr/bin/env bash

set -euo pipefail

source "$(dirname "${BASH_SOURCE[0]}")/../bootstrap.sh"

require_root

ROLE_NAME="Git"

verify_role() {
    log "Verificando configuración de ${ROLE_NAME}..."

    if ! id "$USER_NAME" >/dev/null 2>&1; then
        error "El usuario $USER_NAME no existe."
    fi

    if ! command_exists git; then
        error "Git no está instalado. Ejecuta primero el rol base."
    fi
}

cleanup_role() {
    log "No hay limpieza requerida para ${ROLE_NAME}."
}

install_role() {
    log "No hay instalación requerida para ${ROLE_NAME}."
}

configure_role() {
    log "Configurando ${ROLE_NAME}..."

    sudo -u "$USER_NAME" git config --global user.name "$GIT_NAME"
    sudo -u "$USER_NAME" git config --global user.email "$GIT_EMAIL"
    sudo -u "$USER_NAME" git config --global init.defaultBranch "$GIT_DEFAULT_BRANCH"
    sudo -u "$USER_NAME" git config --global pull.rebase false
    sudo -u "$USER_NAME" git config --global core.editor "$DEFAULT_EDITOR"
}

validate_role() {
    log "Validando ${ROLE_NAME}..."

    sudo -u "$USER_NAME" git config --global --get user.name
    sudo -u "$USER_NAME" git config --global --get user.email
    sudo -u "$USER_NAME" git config --global --get init.defaultBranch
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

