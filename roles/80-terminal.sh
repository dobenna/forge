#!/usr/bin/env bash

set -euo pipefail

source "$(dirname "${BASH_SOURCE[0]}")/../bootstrap.sh"

require_root

ROLE_NAME="Terminal"

get_home() {
    local target_user="$1"

    if [[ "$target_user" == "root" ]]; then
        echo "/root"
    else
        echo "/home/$target_user"
    fi
}

install_oh_my_zsh_for_user() {
    local target_user="$1"
    local user_home="$2"

    if [[ ! -d "$user_home/.oh-my-zsh" ]]; then
        log "Instalando Oh My Zsh para $target_user..."

        sudo -u "$target_user" sh -c \
            'RUNZSH=no CHSH=no KEEP_ZSHRC=yes sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"'
    else
        log "Oh My Zsh ya está instalado para $target_user."
    fi
}

install_zsh_plugin() {
    local target_user="$1"
    local plugin_name="$2"
    local repo_url="$3"
    local destination="$4"

    if [[ ! -d "$destination" ]]; then
        log "Instalando $plugin_name para $target_user..."

        sudo -u "$target_user" git clone --depth=1 "$repo_url" "$destination"
    else
        log "$plugin_name ya está instalado para $target_user."
    fi
}

configure_shell_for_user() {
    local target_user="$1"
    local user_home

    user_home="$(get_home "$target_user")"

    log "Configurando terminal para $target_user..."

    mkdir -p "$user_home/.forge"
    mkdir -p "$user_home/.forge/backups"

    if [[ -f "$user_home/.zshrc" && ! -f "$user_home/.forge/backups/zshrc.bak" ]]; then
        cp "$user_home/.zshrc" "$user_home/.forge/backups/zshrc.bak"
    fi

    install_oh_my_zsh_for_user "$target_user" "$user_home"

    install_zsh_plugin \
        "$target_user" \
        "Powerlevel10k" \
        "https://github.com/romkatv/powerlevel10k.git" \
        "$user_home/.oh-my-zsh/custom/themes/powerlevel10k"

    install_zsh_plugin \
        "$target_user" \
        "zsh-autosuggestions" \
        "https://github.com/zsh-users/zsh-autosuggestions" \
        "$user_home/.oh-my-zsh/custom/plugins/zsh-autosuggestions"

    install_zsh_plugin \
        "$target_user" \
        "zsh-syntax-highlighting" \
        "https://github.com/zsh-users/zsh-syntax-highlighting.git" \
        "$user_home/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting"

    cp "$BOOTSTRAP_DIR/templates/zsh/zshrc" "$user_home/.zshrc"
    cp "$BOOTSTRAP_DIR/templates/zsh/aliases.zsh" "$user_home/.forge/aliases.zsh"
    cp "$BOOTSTRAP_DIR/templates/zsh/exports.zsh" "$user_home/.forge/exports.zsh"
    cp "$BOOTSTRAP_DIR/templates/zsh/functions.zsh" "$user_home/.forge/functions.zsh"

    chown -R "$target_user:$target_user" \
        "$user_home/.zshrc" \
        "$user_home/.forge" \
        "$user_home/.oh-my-zsh"

    local zsh_path
    zsh_path="$(command -v zsh)"

    if [[ "$(getent passwd "$target_user" | cut -d: -f7)" != "$zsh_path" ]]; then
        chsh -s "$zsh_path" "$target_user"
        warn "$target_user debe cerrar sesión y volver a entrar para usar Zsh."
    else
        log "Zsh ya es la shell por defecto de $target_user."
    fi
}

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
    log "La limpieza se realiza por usuario durante la configuración."
}

install_role() {
    log "Instalando herramientas de terminal..."

    install_packages \
        zsh \
        git \
        curl \
        fzf \
        zoxide
}

configure_role() {
    configure_shell_for_user "$USER_NAME"

    if [[ "${CONFIGURE_ROOT_SHELL:-false}" == true ]]; then
        configure_shell_for_user "root"
    fi
}

validate_role() {
    log "Validando ${ROLE_NAME}..."

    zsh --version

    test -d "/home/$USER_NAME/.oh-my-zsh"
    test -d "/home/$USER_NAME/.oh-my-zsh/custom/themes/powerlevel10k"
    test -f "/home/$USER_NAME/.zshrc"

    if [[ "${CONFIGURE_ROOT_SHELL:-false}" == true ]]; then
        test -d "/root/.oh-my-zsh"
        test -d "/root/.oh-my-zsh/custom/themes/powerlevel10k"
        test -f "/root/.zshrc"
    fi

    success "Terminal validada para $USER_NAME y root."
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

