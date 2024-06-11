export PATH=$PATH:~/.deno/bin
export PROMPT="%F{white}%n@%m %B%F{brightwhite}%~ 
%F{%(?.blue.red)}%Bλ%b%f "

alias G="git"
alias hg="history | grep"

ws() {
  vim -c "cd ${1:-.}" \
      -c "vsplit" \
      -c "wincmd l | split" \
      -c "wincmd h | vertical resize 80 | terminal" \
      -c "wincmd j | q"
}
