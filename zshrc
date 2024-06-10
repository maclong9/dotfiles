export PATH=$PATH:~/.mint/bin:~/.deno/bin
export PROMPT="%F{white}%n@%m %B%F{brightwhite}%~ 
%F{%(?.blue.red)}%Bλ%b%f "

alias G="git"
alias hg="history | grep"
alias tks="tmux kill-server"
alias wsf="ws -f"
alias wsb="ws -b"

ws() {
  local flag="$1"
  shift
  local dir="${1:-$PWD}"
  shift
  local session="$(basename "$dir" | tr -d '.')"

  if tmux has-session -t "$session" 2>/dev/null; then
    tmux attach-session -t "$session"
  else
    if [[ "$flag" == "-f" ]]; then
      tmux new-session -d -s "$session" \; \
      send-keys 'cd ' $dir C-m \; \
      send-keys 'vim +Ex' C-m \; \
      split-window -v -p 20 \; \
      send-keys 'cd ' $dir C-m \; \
      send-keys 'clear' C-m \; \
      attach-session -t "$session"
    elif [[ "$flag" == "-b" ]]; then
      tmux new-session -d -s "$session" \; \
      send-keys 'cd ' $dir C-m \; \
      send-keys 'clear' C-m \; \
      split-window -h -p 70 \; \
      select-pane -t 1 \; \
      send-keys 'cd ' $dir C-m \; \
      send-keys 'vim +Ex' C-m \; \
      send-keys ":Sexplore" C-m
      attach-session -t "$session"
    fi
  fi
}

