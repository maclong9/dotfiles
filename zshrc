export PROMPT="%F{white}%n@%m %B%F{brightwhite}%~ 
%F{%(?.blue.red)}%B󰘧%b%f "
export PATH="$PATH:$HOME/.deno/bin/"

mkcd() {
  mkdir "$1" && cd "$1"
}
