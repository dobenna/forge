#!/usr/bin/env bash
set -euo pipefail

require_root() {
    if [[ $EUID -ne 0 ]]; then
        error "Este script debe ejecutarse como root."
    fi
}

command_exists() {
    command -v "$1" >/dev/null 2>&1
}

enable_service() {
    systemctl enable "$1"
    systemctl start "$1"
}
