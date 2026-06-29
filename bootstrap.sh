#!/usr/bin/env bash

BOOTSTRAP_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

source "$BOOTSTRAP_DIR/config.sh"

source "$BOOTSTRAP_DIR/lib/common.sh"
source "$BOOTSTRAP_DIR/lib/system.sh"
source "$BOOTSTRAP_DIR/lib/os.sh"
source "$BOOTSTRAP_DIR/lib/pkg.sh"
source "$BOOTSTRAP_DIR/lib/apt.sh"
source "$BOOTSTRAP_DIR/lib/repository.sh"

require_supported_os
