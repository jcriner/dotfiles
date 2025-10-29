# -----------------------------------------------------------
#  Clean Zsh config using Antidote (no Oh My Zsh)
# -----------------------------------------------------------

# PATH setup
export PATH="$HOME/bin:$PATH"

# History options
HIST_STAMPS="yyyy-mm-dd"
setopt inc_append_history   # Add history lines to the file immediately

# Editor settings
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='nvim'
fi

# -----------------------------------------------------------
#  Antidote plugin manager
# -----------------------------------------------------------
# Auto-install Antidote if missing
ANTIDOTE_DIR="${ZDOTDIR:-$HOME}/.antidote"
if [[ ! -d "$ANTIDOTE_DIR" ]]; then
  echo "Installing Antidote..."
  git clone --depth=1 https://github.com/mattmc3/antidote.git "$ANTIDOTE_DIR"
fi

# Load Antidote
source "$ANTIDOTE_DIR/antidote.zsh"

# -----------------------------------------------------------
#  Plugins (managed by Antidote)
# -----------------------------------------------------------
# Define your plugins list
plugins=(
  MichaelAquilina/zsh-you-should-use
  zsh-users/zsh-autosuggestions
  zsh-users/zsh-syntax-highlighting
)

# Location of Antidote’s bundle file (cached plugin list)
BUNDLE_FILE="${ZDOTDIR:-$HOME}/.zsh_plugins.txt"

# Generate or update the bundle file if it doesn’t exist or is outdated
if [[ ! -f $BUNDLE_FILE ]]; then
  print -l ${plugins[@]} >! "$BUNDLE_FILE"
  antidote bundle <"$BUNDLE_FILE" >! "${BUNDLE_FILE%.txt}.zsh"
fi

# Load plugins from the generated .zsh file
source "${BUNDLE_FILE%.txt}.zsh"

# # Load all plugins
# antidote load ${plugins[@]}

# -----------------------------------------------------------
#  fzf integration
# -----------------------------------------------------------
if command -v fzf &>/dev/null; then
  source <(fzf --zsh)
fi

# -----------------------------------------------------------
#  Prompt (Starship)
# -----------------------------------------------------------
if command -v starship &>/dev/null; then
  eval "$(starship init zsh)"
else
  PROMPT='%n@%m:%~$ '
fi

# -----------------------------------------------------------
#  Aliases
# -----------------------------------------------------------
# alias ll='ls -lah'
# alias gs='git status'
source $ZDOTDIR/aliases.zsh
