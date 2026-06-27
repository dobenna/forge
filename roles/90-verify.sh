#!/usr/bin/env bash

set -euo pipefail

source "$(dirname "${BASH_SOURCE[0]}")/../bootstrap.sh"

require_root

ROLE_NAME="verify"
FAILED=0

check_command() {
    local cmd="$1"
    local label="$2"

    if command -v "$cmd" >/dev/null 2>&1; then
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

verify() {
    log "Verificando sistema base..."

    if grep -q "bookworm" /etc/os-release; then
        success "Debian 12 Bookworm detectado"
    else
        warn "Este sistema no parece ser Debian 12 Bookworm"
        FAILED=1
    fi

    log "Kernel actual: $(uname -r)"
}

cleanup() {
    log "No hay limpieza requerida para verify."
}

install() {
    log "No hay instalación requerida para verify."
}

configure() {
    log "No hay configuración requerida para verify."
}

validate() {
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
    verify
    cleanup
    install
    configure
    validate

    if [[ "$FAILED" -eq 0 ]]; then
        success "Forge verification PASS."
    else
        warn "Forge verification terminó con advertencias."
        exit 1
    fi
}

main "$@"
