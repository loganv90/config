setopt hist_ignore_dups  # don't save duplicate sequential commands to history
export PS1="%n@%m %~ %# "  # show the full path in the prompt
stty stop ^T  # free up ^S so it can be used to forward search

alias ga="git add -p" # git add interactive
alias gr="git restore -p" # git restore interactive

