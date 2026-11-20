#!/usr/bin/env bash
# Bootstrap a machine from this repo: Homebrew, Brewfile, stow packages.
# Safe to re-run.
set -euo pipefail

DOT="$(cd "$(dirname "$0")" && pwd)"
cd "$DOT"

# Homebrew
if ! command -v brew >/dev/null 2>&1; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi
for b in /opt/homebrew/bin/brew /usr/local/bin/brew /home/linuxbrew/.linuxbrew/bin/brew; do
  if [[ -x $b ]]; then
    eval "$("$b" shellenv)"
    break
  fi
done

brew bundle --file="$DOT/Brewfile"

# XDG dirs that zsh writes to
mkdir -p "$HOME/.config" "$HOME/.local/state/zsh" "$HOME/.cache/zsh"

# Every top-level directory is a stow package
PKGS=()
for d in */; do
  PKGS+=("${d%/}")
done

# Dry run first; stow exits non-zero on conflicts
stow -n "${PKGS[@]}"
stow -v "${PKGS[@]}"

echo "Done. Open a new terminal to load the shell config."
