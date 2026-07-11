export HISTSIZE=2000 # lines of history in memory
export SAVEHIST=2000 # lines of history on disk
setopt HIST_IGNORE_ALL_DUPS # only keeps one instance of each command in history
setopt SHARE_HISTORY # shares history between active zsh sessions

export PS1="%n@%m %~ %# "  # show the full path in the prompt
stty stop ^T  # free up ^S so it can be used to forward search

alias ga="git add -p" # git add interactive
alias gr="git restore -p" # git restore interactive

eval "$(mise activate zsh)" # setup mise

