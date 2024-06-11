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

  vim -c "let &rtp=&rtp" -c "cd $dir" \
      -c "vsplit | wincmd l" \
      -c "wincmd H | vertical resize 10 | terminal" \
      -c "wincmd l | Explore" \
      -c "wincmd h | Explore"
}
