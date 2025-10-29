# Look up a command on cheat.sh, e.g., 'howto find'
alias howto='xargs -I STRING curl cheat.sh/STRING <<<'

# Dotfile management via bare git repo.
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'

# Edit quickly
alias e=$EDITOR

# List directory contents
alias ls='ls -G'      # color output
alias lsa='ls -lah'
alias l='ls -lah'
alias ll='ls -lh'
alias la='ls -lAh'

# grep
alias grep='grep --color=auto --exclude-dir={.bzr,CVS,.git,.hg,.svn,.idea,.tox,.venv,venv}'
alias egrep='grep -E'    # use extended regular expressions
alias fgrep='grep -F'    # use fixed strings; no regexp parsing

# Python shortcuts
alias python=python3
alias py=python3
alias ipy=ipython

# tmux shortcut
alias tma='tmux new-session -A -s'

# Example usage: '$ ls | each echo "Processing file {}..."'
alias each='xargs -I {}'

# Type out a long-form idea to add to my script ideas file.
# Note that you must type Ctrl-d to stop input.
alias ideacat="cat >> $HOME/bin/ideas.txt"

# mkcd creates a directory and changes to it.
mkcd () {
  mkdir -p "$1"
  cd "$1" 
}

# tempe changes to a temporary directory.
tempe () {
  cd "$(mktemp -d)"
  chmod -R 0700 .
  if [[ $# -eq 1 ]]; then
    \mkdir -p "$1"
    cd "$1"
    chmod -R 0700 .
  fi
}

# boop plays a sound effect based on the exit status of a command.
boop () {
  local last="$?"
  if [[ "$last" == '0' ]]; then
    sfx good
  else
    sfx bad
  fi
  $(exit "$last")
}

# fh - search in your command history and execute selected command
fh() {
  eval $( ([ -n "$ZSH_NAME" ] && fc -l 1 || history) | fzf +s --tac | sed 's/ *[0-9]* *//')
}
