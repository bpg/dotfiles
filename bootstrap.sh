#!/usr/bin/env bash

set -eu pipefail

OS=""
ARCH="amd64"
USER_BIN="$HOME/.local/bin"

abort () {
  printf "ERROR: %s\n" "$@" >&2
  exit 1
}

log () {
  printf "################################################################################\n"
  printf "%s\n" "$@"
  printf "################################################################################\n"
}

get_arch() {
  arch=$(uname -m)
  if [[ $arch =~ "arm" || $arch =~ "aarch" ]]; then
    ARCH="arm64"
  fi
}

get_os () {
  if [[ "$OSTYPE" =~ "darwin"* ]]; then
    OS="darwin"
    log "Running on Darwin"
  elif [[ "$OSTYPE" =~ "linux" ]]; then
    OS="linux"
    log "Running on Linux"
  fi
}

get_homebrew() {
  log "Installing Homebrew"
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
}

get_tools() {
  brew install git wget curl jq chezmoi age
}  

run_chezmoi() {
  log "Running chezmoi"
  chezmoi init --apply git@github.com:bpg/dotfiles.git
}

main() {
  get_arch
  get_os
  get_homebrew
  get_tools
  for program in wget gunzip tar command chmod rm printf mv mkdir; do
    command -v "$program" > /dev/null 2>&1 || { echo "Not found: $program"; exit 1; }
  done
  
  mkdir -p "${USER_BIN}"
  export PATH=~/.local/bin/:$PATH
  run_chezmoi
  log "Dotfiles configured!"
}

main

