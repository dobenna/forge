#!/usr/bin/env bash
set -euo pipefail

apt_update() {
    log "Actualizando repositorios APT..."
    apt update
}

install_packages() {
    log "Instalando paquetes: $*"
    apt install -y "$@"
}

remove_packages() {
    log "Eliminando paquetes: $*"
    apt remove -y "$@" || true
}
