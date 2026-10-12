#!/usr/bin/env bash
set -Eeuo pipefail

LOG_PREFIX="[obsidian-generator setup]"

log() {
  echo "$LOG_PREFIX $*"
}

require_command() {
  command -v "$1" >/dev/null 2>&1
}

check_and_install_apt() {
  local package="$1"

  if ! dpkg -s "$package" >/dev/null 2>&1; then
    log "Installerer $package via apt-get"
    sudo apt-get update
    sudo apt-get install -y "$package"
  else
    log "$package er allerede installeret"
  fi
}

ensure_fnm() {
  if require_command fnm; then
    log "fnm er allerede installeret"
    return 0
  fi

  log "fnm findes ikke. Installerer fnm"
  curl -fsSL https://fnm.vercel.app/install | bash

  local fnm_init='eval "$(fnm env --use-on-cd --shell bash)"'
  local shell_files=("$HOME/.bashrc" "$HOME/.profile")

  for file in "${shell_files[@]}"; do
    touch "$file"
    if ! grep -Fq 'fnm env --use-on-cd --shell bash' "$file"; then
      printf '\n%s\n' "$fnm_init" >> "$file"
      log "Tilføjede fnm-init til $file"
    fi
  done

  # Load fnm in this shell before continuing.
  eval "$(fnm env --use-on-cd --shell bash)"

  if ! require_command fnm; then
    echo "fnm blev ikke fundet efter installation. Luk terminalen og åbne den igen, før du kører scriptet igen." >&2
    exit 1
  fi
}

ensure_node_lts() {
  if require_command node; then
    log "Node.js er allerede installeret: $(node -v)"
    return 0
  fi

  log "Installerer Node.js LTS med fnm"
  fnm install --lts
  fnm default lts
  eval "$(fnm env --use-on-cd --shell bash)"

  if ! require_command node; then
    echo "Node.js kunne ikke verificeres efter installationen." >&2
    exit 1
  fi

  log "Node.js er klar: $(node -v)"
}

main() {
  if [[ ! -f /etc/os-release ]]; then
    echo "Kunne ikke finde /etc/os-release. Scriptet er beregnet til Ubuntu/Linux." >&2
    exit 1
  fi

  source /etc/os-release

  if [[ "${ID:-}" != "ubuntu" ]]; then
    echo "Dette script er designet til Ubuntu. Din distro ser ud til at være: ${ID:-ukendt}" >&2
    exit 1
  fi

  log "Tjekker udviklingsværktøjer"

  if ! require_command sudo; then
    echo "sudo mangler. Installer sudo først, eller kør scriptet som bruger med sudo adgang." >&2
    exit 1
  fi

  if ! require_command git; then
    check_and_install_apt git
  else
    log "Git er allerede installeret: $(git --version)"
  fi

  if ! require_command gh; then
    check_and_install_apt gh
  else
    log "GitHub CLI er allerede installeret: $(gh --version | head -n 1)"
  fi

  ensure_fnm
  ensure_node_lts

  log "Opsætning er færdig."
  log "Næste trin: kør 'gh auth login' i terminalen, så du kan logge ind i GitHub via browseren."
  log "Kontroller også, at Node og npm virker: node -v && npm -v"
}

main "$@"
