#!/usr/bin/env bash

set -euo pipefail

source "$(dirname "${BASH_SOURCE[0]}")/../bootstrap.sh"

require_root

if [[ "$INSTALL_CHROME" != true ]]; then
    warn "Instalación de Chrome deshabilitada en config.sh"
    exit 0
fi

log "Instalando Google Chrome..."

install_packages ca-certificates curl gnupg

install -m 0755 -d /etc/apt/keyrings

curl -fsSL https://dl.google.com/linux/linux_signing_key.pub \
    | gpg --dearmor -o /etc/apt/keyrings/google-chrome.gpg

chmod 644 /etc/apt/keyrings/google-chrome.gpg

cat > /etc/apt/sources.list.d/google-chrome.list <<EOF
deb [arch=amd64 signed-by=/etc/apt/keyrings/google-chrome.gpg] https://dl.google.com/linux/chrome/deb/ stable main
EOF

apt_update

install_packages google-chrome-stable

success "Google Chrome instalado correctamente."

google-chrome --version || true
