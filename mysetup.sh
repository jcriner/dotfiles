# mysetup.sh
#
# This file includes the various plugins and configuration I need for my
# environment. It assumes a MacOS device. Hopefully this saves me a lot of time
# setting up a new computer when I get a job.

# Install Homebrew
#
# TODO: Decide where this ought to be installed, and for how long I need the file to hang around.
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
# TODO: check that this invokes the script

# TODO: Things I'm looking into:
# - ripgrep
# - eza/exa
# - zoxide
# - starship (powerline)
# - nushell
# - carapace (shell completion library/framework)  <- interest in completion WITHIN commands, but zsh does more of this than I realized

# Install Homebrew packages
#
# TODO: Organize this more distinctly between aesthetics, functionality, etc.
brew_packages=(
	# essentials
	fzf
	fd # improved find, sensible defaults; faster
	ghostty  # cross-platform; and Terminal doesn't support colors
	git
    go
	neovim
	ripgrep  # faster replacement for grep, sensible defaults
    stow  # dotfile management
	tmux
	wget

	# additional
    bat # Rust implementation of cat with syntax highlighting, etc; trying it for previews in fzf
	broot # file explorer thingy
	ngrep # network grep
	python
	tlrc  # the Homebrew name for the 'tldr' service for simpler man pages
	tree # tree-like display; e.g., `tree -L 2` (limit depth to two)
	typescript-language-server # get LSP support for Javascript, etc.
	"--cask wireshark" # needs to be the cask to get the GUI

    mpv # media player
    yt-dlp # YouTube downloader
    
	# not sure yet
	fish

	# fonts and aesthetics
	font-anonymice-nerd-font
	nerdfonts
	starship

	# window management
	"--cask nikitabobko/tap/aerospace"  # i3-like WM for MacOS
)
for pkg in brew_packages; do "brew install $pkg"; done

# Some packages may require extra linking to ensure I use the version I
# installed, rather than the one bundled with the system.
brew_linked_packages=(
	git
	python
)
for pkg in brew_linked_packages; do "brew link $pkg"; done

# TODOs:
# - oh-my-zsh installation (if continuing to use that)
# - putting my dotfiles in a git repo, pulling them

# From a Reddit comment:
#   If you like this then you may also enjoy:
# 
# ripgrep (grep)
# eza (ls)
# fd (find)
# jq (json awk/sed like tool)
# fzf (fuzzy finder)
# watchexec (watches dir for changes and runs a command)
# ion (shell)
# runiq (uniq)
