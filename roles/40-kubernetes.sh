#!/usr/bin/env bash

set -euo pipefail

source "$(dirname "${BASH_SOURCE[0]}")/../bootstrap.sh"

require_root

if [[ "$INSTALL_KUBERNETES" != true ]]; then
    warn "Instalación de Kubernetes deshabilitada en config.sh"
    exit 0
fi

log "Instalando herramientas Kubernetes..."

install_packages \
    ca-certificates \
    curl \
    gnupg

log "Configurando repositorio oficial de kubectl..."

install -m 0755 -d /etc/apt/keyrings

curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.33/deb/Release.key \
    | gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg

chmod 644 /etc/apt/keyrings/kubernetes-apt-keyring.gpg

cat > /etc/apt/sources.list.d/kubernetes.list <<EOF
deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.33/deb/ /
EOF

apt_update

log "Instalando kubectl..."

install_packages kubectl

log "Configurando repositorio oficial de Helm..."

curl -fsSL https://packages.buildkite.com/helm-linux/helm-debian/gpgkey \
    | gpg --dearmor -o /etc/apt/keyrings/helm.gpg

chmod 644 /etc/apt/keyrings/helm.gpg

cat > /etc/apt/sources.list.d/helm.list <<EOF
deb [signed-by=/etc/apt/keyrings/helm.gpg] https://packages.buildkite.com/helm-linux/helm-debian/any/ any main
EOF

apt_update

log "Instalando Helm..."

install_packages helm

log "Instalando kind..."

KIND_VERSION="${KIND_VERSION:-v0.32.0}"

curl -Lo /usr/local/bin/kind "https://kind.sigs.k8s.io/dl/${KIND_VERSION}/kind-linux-amd64"

chmod +x /usr/local/bin/kind

success "Herramientas Kubernetes instaladas correctamente."

kubectl version --client || true
helm version || true
kind --version || true
