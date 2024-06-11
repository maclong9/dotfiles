export PATH=$PATH:~/.mint/bin:~/.deno/bin
export PROMPT="%F{white}%n@%m %B%F{brightwhite}%~ 
%F{%(?.blue.red)}%Bλ%b%f "

alias G="git"
alias hg="history | grep"
alias tks="tmux kill-server"
alias wsf="ws -f"
alias wsb="ws -b"

ws() {
  local dir=${1:-.}

  vim -c "cd $dir" \
      -c "vsplit" \
      -c "wincmd l | split" \
      -c "wincmd h | vertical resize 80 | terminal" \
      -c "wincmd j | q" \
      -c "wincmd l"
}

