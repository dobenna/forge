#!/usr/bin/env bash

set -euo pipefail

source "$(dirname "${BASH_SOURCE[0]}")/../bootstrap.sh"

require_root

ROLE_NAME="Verify"
FAILED=0

check_command() {
    local cmd="$1"
    local label="$2"

    if command_exists "$cmd"; then
        success "$label encontrado: $(command -v "$cmd")"
    else
        warn "$label no encontrado"
        FAILED=1
    fi
}

check_service() {
    local service="$1"

    if systemctl is-active --quiet "$service"; then
        success "Servicio activo: $service"
    else
        warn "Servicio no activo: $service"
        FAILED=1
    fi
}

check_group() {
    local user="$1"
    local group="$2"

    if id -nG "$user" | grep -qw "$group"; then
        success "Usuario $user pertenece al grupo $group"
    else
        warn "Usuario $user NO pertenece al grupo $group"
        FAILED=1
    fi
}

verify_role() {
    log "Verificando sistema base..."

    if grep -q "bookworm" /etc/os-release; then
        success "Debian 12 Bookworm detectado"
    else
        warn "Este sistema no parece ser Debian 12 Bookworm"
        FAILED=1
    fi

    log "Kernel actual: $(uname -r)"
}

cleanup_role() {
    log "No hay limpieza requerida para ${ROLE_NAME}."
}

install_role() {
    log "No hay instalación requerida para ${ROLE_NAME}."
}

configure_role() {
    log "No hay configuración requerida para ${ROLE_NAME}."
}

validate_role() {
    log "Verificando herramientas instaladas..."

    check_command git "Git"
    check_command docker "Docker"
    check_command kubectl "kubectl"
    check_command helm "Helm"
    check_command kind "Kind"
    check_command terraform "Terraform"
    check_command code "VS Code"
    check_command google-chrome "Google Chrome"
    check_command python3 "Python 3"
    check_command pip3 "pip3"

    check_service docker
    check_group "$USER_NAME" docker

    log "Espacio en disco:"
    df -h /

    log "Memoria:"
    free -h
}

main() {
    verify_role
    cleanup_role
    install_role
    configure_role
    validate_role

    if [[ "$FAILED" -eq 0 ]]; then
        success "Rol ${ROLE_NAME} completado correctamente."
    else
        warn "Rol ${ROLE_NAME} terminó con advertencias."
        exit 1
    fi
}

main "$@"

