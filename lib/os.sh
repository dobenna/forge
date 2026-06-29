#!/usr/bin/env bash

set -euo pipefail

OS_ID=""
OS_VERSION_ID=""
OS_CODENAME=""
OS_FAMILY=""
PKG_MANAGER=""

detect_os() {
    if [[ ! -f /etc/os-release ]]; then
        error "No se encontró /etc/os-release."
    fi

    # shellcheck disable=SC1091
    source /etc/os-release

    OS_ID="${ID:-unknown}"
    OS_VERSION_ID="${VERSION_ID:-unknown}"
    OS_CODENAME="${VERSION_CODENAME:-}"

    case "$OS_ID" in
        debian|ubuntu|linuxmint|pop)
            OS_FAMILY="debian"
            PKG_MANAGER="apt"
            ;;
        rhel|rocky|almalinux|centos|fedora)
            OS_FAMILY="redhat"
            if command -v dnf >/dev/null 2>&1; then
                PKG_MANAGER="dnf"
            elif command -v yum >/dev/null 2>&1; then
                PKG_MANAGER="yum"
            else
                error "No se encontró dnf ni yum."
            fi
            ;;
        *)
            error "Distribución no soportada todavía: $OS_ID"
            ;;
    esac

    log "Sistema detectado: $OS_ID $OS_VERSION_ID ($OS_FAMILY / $PKG_MANAGER)"
}

require_supported_os() {
    detect_os
}
