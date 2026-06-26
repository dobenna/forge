#!/usr/bin/env bash

set -euo pipefail

source "$(dirname "${BASH_SOURCE[0]}")/../bootstrap.sh"

require_root

if [[ "$INSTALL_VSCODE" != true ]]; then
    warn "Instalación de VS Code deshabilitada en config.sh"
    exit 0
fi

log "Instalando Visual Studio Code..."

install_packages wget gpg apt-transport-https

install -m 0755 -d /etc/apt/keyrings

wget -qO- https://packages.microsoft.com/keys/microsoft.asc \
    | gpg --dearmor -o /etc/apt/keyrings/packages.microsoft.gpg

chmod 644 /etc/apt/keyrings/packages.microsoft.gpg

cat > /etc/apt/sources.list.d/vscode.list <<EOF
deb [arch=amd64,arm64,armhf signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main
EOF

apt_update

install_packages code

success "Visual Studio Code instalado correctamente."

code --version || true
