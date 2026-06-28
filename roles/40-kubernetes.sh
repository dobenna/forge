#!/usr/bin/env bash

set -euo pipefail

source "$(dirname "${BASH_SOURCE[0]}")/../bootstrap.sh"

require_root

ROLE_NAME="Kubernetes"

verify_role() {
    log "Verificando configuración de ${ROLE_NAME}..."

    if [[ "$INSTALL_KUBERNETES" != true ]]; then
        warn "Instalación de Kubernetes deshabilitada en config.sh"
        exit 0
    fi
}

cleanup_role() {
    log "No hay limpieza requerida para ${ROLE_NAME}."
}

install_role() {
    log "Instalando ${ROLE_NAME}..."

    install_packages \
        ca-certificates \
        curl \
        gnupg

    create_keyring_dir

    download_gpg_key \
        "https://pkgs.k8s.io/core:/stable:/v1.33/deb/Release.key" \
        "/etc/apt/keyrings/kubernetes-apt-keyring.gpg"

    create_repository \
        "/etc/apt/sources.list.d/kubernetes.list" \
        "deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.33/deb/ /"

    download_gpg_key \
        "https://packages.buildkite.com/helm-linux/helm-debian/gpgkey" \
        "/etc/apt/keyrings/helm.gpg"

    create_repository \
        "/etc/apt/sources.list.d/helm.list" \
        "deb [signed-by=/etc/apt/keyrings/helm.gpg] https://packages.buildkite.com/helm-linux/helm-debian/any/ any main"

    refresh_repositories

    install_packages \
        kubectl \
        helm

    local kind_version="${KIND_VERSION:-v0.32.0}"

    log "Instalando kind ${kind_version}..."

    curl -fsSL \
        -o /usr/local/bin/kind \
        "https://kind.sigs.k8s.io/dl/${kind_version}/kind-linux-amd64"

    chmod +x /usr/local/bin/kind
}

configure_role() {
    log "No hay configuración adicional para ${ROLE_NAME}."
}

validate_role() {
    log "Validando ${ROLE_NAME}..."

    kubectl version --client
    helm version
    kind --version
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

