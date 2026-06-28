#!/usr/bin/env bash

set -euo pipefail

source "$(dirname "${BASH_SOURCE[0]}")/../bootstrap.sh"

require_root

ROLE_NAME="Terminal"

verify_role() {
    log "Verificando configuración de ${ROLE_NAME}..."

    if [[ "$INSTALL_ZSH" != true ]]; then
        warn "Instalación de Zsh deshabilitada en config.sh"
        exit 0
    fi

    if ! id "$USER_NAME" >/dev/null 2>&1; then
        error "El usuario $USER_NAME no existe."
    fi
}

cleanup_role() {
    log "Respaldando configuración Zsh previa si existe..."

    local user_home="/home/$USER_NAME"
    local backup_dir="$user_home/.forge/backups"

    sudo -u "$USER_NAME" mkdir -p "$backup_dir"

    if [[ -f "$user_home/.zshrc" && ! -f "$backup_dir/zshrc.bak" ]]; then
        cp "$user_home/.zshrc" "$backup_dir/zshrc.bak"
    fi
}

install_role() {
    log "Instalando herramientas de terminal..."

    install_packages \
        zsh \
        git \
        curl \
        fzf \
        zoxide

    local user_home="/home/$USER_NAME"

    if [[ ! -d "$user_home/.oh-my-zsh" ]]; then
        log "Instalando Oh My Zsh..."
        sudo -u "$USER_NAME" sh -c \
            'RUNZSH=no CHSH=no KEEP_ZSHRC=yes sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"'
    else
        log "Oh My Zsh ya está instalado."
    fi

    if [[ ! -d "$user_home/.oh-my-zsh/custom/themes/powerlevel10k" ]]; then
        log "Instalando Powerlevel10k..."
        sudo -u "$USER_NAME" git clone --depth=1 \
            https://github.com/romkatv/powerlevel10k.git \
            "$user_home/.oh-my-zsh/custom/themes/powerlevel10k"
    else
        log "Powerlevel10k ya está instalado."
    fi

    if [[ ! -d "$user_home/.oh-my-zsh/custom/plugins/zsh-autosuggestions" ]]; then
        log "Instalando zsh-autosuggestions..."
        sudo -u "$USER_NAME" git clone --depth=1 \
            https://github.com/zsh-users/zsh-autosuggestions \
            "$user_home/.oh-my-zsh/custom/plugins/zsh-autosuggestions"
    else
        log "zsh-autosuggestions ya está instalado."
    fi

    if [[ ! -d "$user_home/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting" ]]; then
        log "Instalando zsh-syntax-highlighting..."
        sudo -u "$USER_NAME" git clone --depth=1 \
            https://github.com/zsh-users/zsh-syntax-highlighting.git \
            "$user_home/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting"
    else
        log "zsh-syntax-highlighting ya está instalado."
    fi
}

configure_role() {
    log "Configurando terminal para $USER_NAME..."

    local user_home="/home/$USER_NAME"
    local forge_dir="$user_home/.forge"

    sudo -u "$USER_NAME" mkdir -p "$forge_dir"

    cp "$BOOTSTRAP_DIR/templates/zsh/zshrc" "$user_home/.zshrc"
    cp "$BOOTSTRAP_DIR/templates/zsh/aliases.zsh" "$forge_dir/aliases.zsh"
    cp "$BOOTSTRAP_DIR/templates/zsh/exports.zsh" "$forge_dir/exports.zsh"
    cp "$BOOTSTRAP_DIR/templates/zsh/functions.zsh" "$forge_dir/functions.zsh"

    chown "$USER_NAME:$USER_NAME" \
        "$user_home/.zshrc" \
        "$forge_dir/aliases.zsh" \
        "$forge_dir/exports.zsh" \
        "$forge_dir/functions.zsh"

    local zsh_path
    zsh_path="$(command -v zsh)"

    if [[ "$(getent passwd "$USER_NAME" | cut -d: -f7)" != "$zsh_path" ]]; then
        chsh -s "$zsh_path" "$USER_NAME"
        warn "Cierra sesión y vuelve a entrar para usar Zsh como shell por defecto."
    else
        log "Zsh ya es la shell por defecto de $USER_NAME."
    fi
}

validate_role() {
    log "Validando ${ROLE_NAME}..."

    zsh --version
    sudo -u "$USER_NAME" test -d "/home/$USER_NAME/.oh-my-zsh"
    sudo -u "$USER_NAME" test -d "/home/$USER_NAME/.oh-my-zsh/custom/themes/powerlevel10k"
    sudo -u "$USER_NAME" test -f "/home/$USER_NAME/.zshrc"

    success "Zsh, Oh My Zsh y Powerlevel10k validados."
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

