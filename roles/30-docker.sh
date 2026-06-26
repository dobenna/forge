#!/usr/bin/env bash

set -euo pipefail

source "$(dirname "${BASH_SOURCE[0]}")/../bootstrap.sh"

require_root

[[ "$INSTALL_DOCKER" == true ]] || exit 0

log "Instalando Docker..."

remove_packages \
    docker.io \
    docker-compose \
    docker-doc \
    podman-docker \
    containerd \
    runc

install_packages \
    ca-certificates \
    curl \
    gnupg

install -m 0755 -d /etc/apt/keyrings

curl -fsSL https://download.docker.com/linux/debian/gpg \
-o /etc/apt/keyrings/docker.asc

chmod a+r /etc/apt/keyrings/docker.asc

cat >/etc/apt/sources.list.d/docker.list <<EOF
deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/debian bookworm stable
EOF

apt_update

install_packages \
    docker-ce \
    docker-ce-cli \
    containerd.io \
    docker-buildx-plugin \
    docker-compose-plugin

enable_service docker

usermod -aG docker "$USER_NAME"

success "Docker instalado."

docker --version
docker compose version
