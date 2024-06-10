export PATH=$PATH:~/.mint/bin:~/.deno/bin
export PROMPT="%F{white}%n@%m %B%F{brightwhite}%~ 
%F{%(?.blue.red)}%Bλ%b%f "

alias g="git"
alias ls="sls -cli"
alias la="sls -acli"
alias lr="sls -clir"
alias lar="sls -aclir"
alias hg="history | grep"
alias tks="tmux kill-server"
alias wsf="ws -f"
alias wsb="ws -b"

ws() {
  local flag="$1"; shift
  local dir="${1:-$PWD}"; shift
	local session="$(basename "$dir" | tr -d '.')_$$"

	echo "$flag"
	echo "$dir"
  echo $session

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
      send-keys ":Sexplore" C-m \; \
      attach-session -t "$session"
  fi
}

