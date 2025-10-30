# -----------------------------------------------------------
#  Basic config
# -----------------------------------------------------------

# PATH setup
export PATH="$HOME/bin:$PATH"

# History options
HIST_STAMPS="yyyy-mm-dd"
setopt inc_append_history   # Add history lines to the file immediately
export HISTSIZE=10000  # in-memory
export SAVEHIST=500000
# TODO: More stuff to figure out here:
# export HISTFILE=$ZDOTDIR/.hist_zsh
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

# Editor settings
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='nvim'
fi

# -----------------------------------------------------------
# Add completion and syntax highlighting.
# -----------------------------------------------------export i------

ZPLUGINS="$ZDOTDIR/plugins"
mkdir -p $ZPLUGINS

if [[ ! -e $ZPLUGINS/zsh-syntax-highlighting ]]; then
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZPLUGINS/zsh-syntax-highlighting
fi

if [[ ! -e $ZPLUGINS/zsh-autosuggestions ]]; then
  git clone https://github.com/zsh-users/zsh-autosuggestions.git $ZPLUGINS/zsh-autosuggestions
fi

autoload -Uz compinit
compinit

source $ZPLUGINS/zsh-syntax-highlighting/zsh-syntax-highlighting.plugin.zsh
source $ZPLUGINS/zsh-autosuggestions/zsh-autosuggestions.plugin.zsh

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
