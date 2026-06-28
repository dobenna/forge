#!/usr/bin/env bash

set -euo pipefail

#################################################
# Repository Library
#################################################

create_keyring_dir() {

    command install -m 0755 -d /etc/apt/keyrings

}

#################################################

download_gpg_key() {

    local url="$1"
    local output="$2"

    if [[ ! -f "$output" ]]; then

        log "Descargando llave GPG..."

        curl -fsSL "$url" \
            | gpg --dearmor -o "$output"

        chmod 644 "$output"

    else

        log "La llave GPG ya existe."

    fi

}

#################################################

create_repository() {

    local file="$1"
    local content="$2"

    if [[ ! -f "$file" ]]; then

        log "Creando repositorio $(basename "$file")"

        echo "$content" > "$file"

    else

        log "Repositorio $(basename "$file") ya existe."

    fi

}

#################################################

refresh_repositories() {

    apt_update

}
