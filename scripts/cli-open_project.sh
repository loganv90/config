#!/usr/bin/env bash
set -euo pipefail

roots=("$HOME/Documents/repos")

selected=$(
    fd --min-depth 1 --max-depth 1 --type d --absolute-path . "${roots[@]}" \
        | awk '{
              line=$0; sub(/\/$/,"",line)
              n=split(line, p, "/"); base=p[n]
              dir=substr(line, 1, length(line)-length(base))
              printf "\033[2m%s\033[0m\033[1;36m%s\033[0m\n", dir, base
          }' \
        | fzf --ansi --prompt="project > " \
              --height=40% --reverse \
              --query="${1:-}" \
              --select-1 --exit-0
)

[ -z "$selected" ] && { echo "No selection" >&2; exit 1; }

selected="${selected%/}"
name="$(basename "$selected")"
# tmux session names can't contain '.' or ':'
session="${name//[.:]/_}"

if ! tmux has-session -t "=$session" 2>/dev/null; then
    tmux new-session -d -s "$session" -c "$selected"
fi

if [ -n "${TMUX:-}" ]; then
    tmux switch-client -t "=$session"
else
    tmux attach-session -t "=$session"
fi

