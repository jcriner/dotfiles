# -----------------------------------------------------------
#  Minimal Zsh config (no oh-my-zsh)
# -----------------------------------------------------------

# PATH setup
export PATH="$HOME/bin:$PATH"

# History
# TODO: More stuff to figure out here:
# export HISTFILE=$ZDOTDIR/.hist_zsh
# export HISTSIZE=5000000
# export SAVEHIST=$HISTSIZE
#
# # HISTORY
# setopt EXTENDED_HISTORY          # Write the history file in the ':start:elapsed;command' format.
# setopt HIST_EXPIRE_DUPS_FIRST    # Expire a duplicate event first when trimming history.
# setopt HIST_FIND_NO_DUPS         # Do not display a previously found event.
# setopt HIST_IGNORE_ALL_DUPS      # Delete an old recorded event if a new event is a duplicate.
# setopt HIST_IGNORE_DUPS          # Do not record an event that was just recorded again.
# setopt HIST_IGNORE_SPACE         # Do not record an event starting with a space.
# setopt HIST_SAVE_NO_DUPS         # Do not write a duplicate event to the history file.
# setopt SHARE_HISTORY             # Share history between all sessions.
# # END HISTORY
HIST_STAMPS="yyyy-mm-dd"
SAVEHIST=50000 # history file size
HISTSIZE=10000 # in-memory
setopt inc_append_history  # Add history lines immediately

# Editor settings
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='nvim'
fi

# -----------------------------------------------------------
#  Plugins
# -----------------------------------------------------------
# Create a directory for plugins if it doesn’t exist
ZSH_PLUGINS_DIR="$HOME/.zsh/plugins"
mkdir -p "$ZSH_PLUGINS_DIR"

# Clone any missing plugins
if [[ ! -d $ZSH_PLUGINS_DIR/zsh-autosuggestions ]]; then
  git clone https://github.com/zsh-users/zsh-autosuggestions "$ZSH_PLUGINS_DIR/zsh-autosuggestions"
fi

if [[ ! -d $ZSH_PLUGINS_DIR/zsh-syntax-highlighting ]]; then
  git clone https://github.com/zsh-users/zsh-syntax-highlighting "$ZSH_PLUGINS_DIR/zsh-syntax-highlighting"
fi

if [[ ! -d $ZSH_PLUGINS_DIR/you-should-use ]]; then
  git clone https://github.com/MichaelAquilina/zsh-you-should-use "$ZSH_PLUGINS_DIR/you-should-use"
fi

# Load plugins
source "$ZSH_PLUGINS_DIR/zsh-autosuggestions/zsh-autosuggestions.zsh"
source "$ZSH_PLUGINS_DIR/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
source "$ZSH_PLUGINS_DIR/you-should-use/you-should-use.plugin.zsh"

# -----------------------------------------------------------
#  fzf integration
# -----------------------------------------------------------
if command -v fzf &>/dev/null; then
  source <(fzf --zsh)
fi

# -----------------------------------------------------------
#  Prompt
# -----------------------------------------------------------
# Using starship (cross-shell prompt)
if command -v starship &>/dev/null; then
  eval "$(starship init zsh)"
else
  PROMPT='%n@%m:%~$ '
fi

# -----------------------------------------------------------
#  Aliases (add your own here)
# -----------------------------------------------------------
# alias ll='ls -lah'
# alias gs='git status'
source $ZSHDOTDIR/aliases.zsh

# fh - search in your command history and execute selected command
fh() {
  eval $( ([ -n "$ZSH_NAME" ] && fc -l 1 || history) | fzf +s --tac | sed 's/ *[0-9]* *//')
}
