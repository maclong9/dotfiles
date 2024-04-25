export PATH="$PATH:$HOME/.deno/bin/"
export PROMPT="%F{white}%n@%m %B%F{brightwhite}%~ 
%F{%(?.blue.red)}%Bλ%b%f "

alias g="git"
alias hg="history | grep"
alias dev="cd ~/Developer"
alias cnf="cd ~/.config"

gc() {
  base_url="git@github.com:"
  if [[ "$1" == *"/"* ]]; then
    git clone "$base_url/$1.git"
  else
    git clone "$base_url/maclong9/$1.git"
  fi
}
