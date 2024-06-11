export PATH=$PATH:~/.deno/bin
export PROMPT="%F{white}%n@%m %B%F{brightwhite}%~ 
%F{%(?.blue.red)}%Bλ%b%f "

alias G="git"
alias hg="history | grep"

ws() {
  vim -c "cd ${1:-.}" \
      -c "leftabove vsplit | terminal | vertical resize 80" \
      -c "wincmd l | split"
}
