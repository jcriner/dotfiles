#!/usr/bin/env bash
#
# mysetup.sh
#
# Bootstraps a fresh macOS machine: installs Homebrew, then everything listed
# in Brewfile. Run from the directory containing this script and Brewfile:
#
#   ./mysetup.sh
#
# The steps should be organized as follows:
# 1. Install Homebrew
# 2. Install packages and applications (brew bundle)
# 3. MacOS configuration (or other host OS)
# 4. Shell configuration
# 5. Text editor configuration
# 6. General application configuration

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# 1. Install Homebrew (skip if already installed).
if ! command -v brew >/dev/null 2>&1; then
	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi
eval "$(brew shellenv)"

# 2. Install everything from Brewfile.
brew bundle --file="$SCRIPT_DIR/Brewfile"

# TODO
# 3. Install my dotfiles repo from GitHub
