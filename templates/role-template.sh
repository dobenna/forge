#!/usr/bin/env bash

set -euo pipefail

source "$(dirname "${BASH_SOURCE[0]}")/../bootstrap.sh"

require_root

ROLE_NAME="example"

verify() {
    log "Verificando prerequisitos para ${ROLE_NAME}..."
}

cleanup() {
    log "Limpiando configuraciones previas de ${ROLE_NAME}..."
}

install() {
    log "Instalando ${ROLE_NAME}..."
}

configure() {
    log "Configurando ${ROLE_NAME}..."
}

validate() {
    log "Validando ${ROLE_NAME}..."
}

main() {
    verify
    cleanup
    install
    configure
    validate

    success "Rol ${ROLE_NAME} completado correctamente."
}

main "$@"
