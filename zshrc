export PATH=$PATH:~/.mint/bin:~/.deno/bin
export PROMPT="%F{white}%n@%m %B%F{brightwhite}%~ 
%F{%(?.blue.red)}%Bλ%b%f "

alias G="git"
alias hg="history | grep"
alias tks="tmux kill-server"
alias wsf="ws -f"
alias wsb="ws -b"


ws() {
  local dir="${1:-$PWD}"
  local session=$(basename "$dir" | tr -d '.')
  tmux new-session -d -s "$session" \; \
      send-keys 'cd ' $dir C-m \; \
      send-keys 'clear' C-m \; \
      split-window -h -l 70 \; \
      select-pane -t 1 \; \
      send-keys 'cd ' $dir C-m \; \
      send-keys 'vim +Ex' C-m \; \
      send-keys ":Sexplore" C-m \; \
      attach-session -t "$session"
}

