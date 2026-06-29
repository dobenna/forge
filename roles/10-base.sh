#!/usr/bin/env bash

set -euo pipefail

source "$(dirname "${BASH_SOURCE[0]}")/../bootstrap.sh"

require_root

ROLE_NAME="Base"

verify_role() {
    log "Verificando sistema para ${ROLE_NAME}..."

    if [[ "$OS_FAMILY" != "debian" && "$OS_FAMILY" != "redhat" ]]; then
        error "Familia de sistema no soportada: $OS_FAMILY"
    fi
}

cleanup_role() {
    log "No hay limpieza requerida para ${ROLE_NAME}."
}

install_role() {
    log "Actualizando repositorios..."

    pkg_update

    log "Instalando paquetes base..."

    case "$OS_FAMILY" in
        debian)
            pkg_install \
                ca-certificates curl wget gnupg lsb-release apt-transport-https \
                software-properties-common build-essential git nano vim unzip zip tree \
                htop btop tmux rsync jq yq ripgrep fd-find bat fzf dnsutils net-tools \
                nmap tcpdump lsof strace python3 python3-pip python3-venv python3-dev \
                openssh-client openssh-server sudo
            ;;

        redhat)
            pkg_install \
                ca-certificates curl wget gnupg git nano vim unzip zip tree \
                htop btop tmux rsync jq ripgrep fd-find bat fzf bind-utils net-tools \
                nmap tcpdump lsof strace python3 python3-pip python3-devel \
                openssh-clients openssh-server sudo gcc gcc-c++ make
            ;;
    esac
}

configure_role() {
    log "No hay configuración adicional para ${ROLE_NAME}."
}

validate_role() {
    log "Validando herramientas base..."

    git --version
    curl --version | head -1
    python3 --version
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

