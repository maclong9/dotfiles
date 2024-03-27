export PATH="$PATH:$HOME/.deno/bin/"
export PROMPT="%F{white}%n@%m %B%F{brightwhite}%~ 
%F{%(?.blue.red)}%B󰘧%b%f " # Sets prompt to Lambda Character with a foreground of Red or Blue depending on previous commands exit code.

alias g="git"

mkcd() {
  mkdir "$1" && cd "$1"
}
