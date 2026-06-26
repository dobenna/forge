#!/usr/bin/env bash

set -euo pipefail

source "$(dirname "${BASH_SOURCE[0]}")/../bootstrap.sh"

require_root

log "Configurando Git..."

if ! id "$USER_NAME" >/dev/null 2>&1; then
    error "El usuario $USER_NAME no existe."
fi

sudo -u "$USER_NAME" git config --global user.name "$GIT_NAME"
sudo -u "$USER_NAME" git config --global user.email "$GIT_EMAIL"
sudo -u "$USER_NAME" git config --global init.defaultBranch "$GIT_DEFAULT_BRANCH"
sudo -u "$USER_NAME" git config --global pull.rebase false
sudo -u "$USER_NAME" git config --global core.editor "$DEFAULT_EDITOR"

success "Git configurado."
