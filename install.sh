#!/usr/bin/env bash
set -euo pipefail

BOOTSTRAP_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROLES_DIR="$BOOTSTRAP_DIR/roles"

run_role() {
    local role="$1"
    local match

    match="$(find "$ROLES_DIR" -maxdepth 1 -type f -name "*${role}*.sh" | sort | head -n 1)"

    if [[ -z "$match" ]]; then
        echo "Rol no encontrado: $role"
        exit 1
    fi

    bash "$match"
}

run_all() {
    for role in "$ROLES_DIR"/*.sh; do
        bash "$role"
    done
}

case "${1:-all}" in
    all)
        run_all
        ;;
    list)
        ls -1 "$ROLES_DIR"/*.sh | xargs -n1 basename
        ;;
    *)
        run_role "$1"
        ;;
esac

