#!/usr/bin/env bash
set -euo pipefail
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TARGET="${HOME}/.config/nvim-spring-ide"
if [[ -e "${TARGET}" ]]; then
  echo "Profile already exists: ${TARGET}"
  echo "Aborting to keep your files safe."
  exit 1
fi
mkdir -p "${HOME}/.config"
cp -R "${ROOT}/config" "${TARGET}"
echo "Installed ${TARGET}"
echo "Start from repository root: NVIM_APPNAME=nvim-spring-ide nvim ."
