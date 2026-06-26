#!/usr/bin/env bash

set -euo pipefail

source "$(dirname "${BASH_SOURCE[0]}")/../bootstrap.sh"

require_root

if [[ "$INSTALL_TERRAFORM" != true ]]; then
    warn "Instalación de Terraform deshabilitada en config.sh"
    exit 0
fi

log "Instalando Terraform..."

install_packages ca-certificates curl gnupg

install -m 0755 -d /etc/apt/keyrings

curl -fsSL https://apt.releases.hashicorp.com/gpg \
    | gpg --dearmor -o /etc/apt/keyrings/hashicorp.gpg

chmod 644 /etc/apt/keyrings/hashicorp.gpg

cat > /etc/apt/sources.list.d/hashicorp.list <<EOF
deb [signed-by=/etc/apt/keyrings/hashicorp.gpg] https://apt.releases.hashicorp.com bookworm main
EOF

apt_update

install_packages terraform

success "Terraform instalado correctamente."

terraform version || true
