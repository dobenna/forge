#!/usr/bin/env bash

set -euo pipefail

pkg_update() {
    case "$PKG_MANAGER" in
        apt)
            apt update
            ;;
        dnf)
            dnf makecache
            ;;
        yum)
            yum makecache
            ;;
        *)
            error "Gestor de paquetes no soportado: $PKG_MANAGER"
            ;;
    esac
}

pkg_install() {
    case "$PKG_MANAGER" in
        apt)
            apt install -y "$@"
            ;;
        dnf)
            dnf install -y "$@"
            ;;
        yum)
            yum install -y "$@"
            ;;
        *)
            error "Gestor de paquetes no soportado: $PKG_MANAGER"
            ;;
    esac
}

pkg_remove() {
    case "$PKG_MANAGER" in
        apt)
            apt remove -y "$@" || true
            ;;
        dnf)
            dnf remove -y "$@" || true
            ;;
        yum)
            yum remove -y "$@" || true
            ;;
        *)
            error "Gestor de paquetes no soportado: $PKG_MANAGER"
            ;;
    esac
}
