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

# 2. Dotfiles
DOTFILES_REPO="git@github.com:jcriner/dotfiles.git"
DOTFILES_GIT_DIR="$HOME/.cfg"
DOTFILES_BACKUP="$HOME/.dotfiles-backup"

if [[ ! -d "$DOTFILES_GIT_DIR" ]]; then
	git clone --bare "$DOTFILES_REPO" "$DOTFILES_GIT_DIR"
fi

# Temporary function -- the real `dotfiles` binary isn't available yet
_df() { git --work-tree="$HOME" --git-dir="$DOTFILES_GIT_DIR" "$@"; }

# Back up any files that would conflict with checkout
checkout_output=$(_df checkout 2>&1) || true
conflict_files=$(echo "$checkout_output" | grep -E "^\s+\." | awk '{print $1}')
if [[ -n "$conflict_files" ]]; then
	echo "Backing up conflicting files to $DOTFILES_BACKUP"
	while IFS= read -r f; do
		mkdir -p "$DOTFILES_BACKUP/$(dirname "$f")"
		mv "$HOME/$f" "$DOTFILES_BACKUP/$f"
	done <<< "$conflict_files"
fi

_df checkout
_df config --local status.showUntrackedFiles no
chmod +x "$HOME/bin/dotfiles"

echo "Dotfiles installed. Conflicts (if any) backed up to $DOTFILES_BACKUP."

# 3. Install everything from Brewfile.
brew bundle --file="$SCRIPT_DIR/Brewfile"

# TODO
# 4. Install my dotfiles repo from GitHub
