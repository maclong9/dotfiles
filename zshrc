export PATH="$PATH:$HOME/.deno/bin/"
export PROMPT="%F{white}%n@%m %B%F{brightwhite}%~ 
%F{%(?.blue.red)}%B󰘧%b%f "

alias g="git"

mkcd() {
  mkdir "$1" && cd "$1"
}
