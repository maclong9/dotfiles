export PATH="$PATH:$HOME/.deno/bin/"
export PROMPT="%F{white}%n@%m %B%F{brightwhite}%~ 
%F{%(?.blue.red)}%B󰘧%b%f "

alias g="git"

mkcd() {
  mkdir "$1" && cd "$1"
}

gc() {
  base_url="https://github.com"
  if [[ "$1" == *"https"* ]]; then
    git clone "$1"
  elif [[ "$1" == *"/"* ]]; then
    git clone "$base_url/$1"
  else
    git clone "$base_url/maclong9/$1"
  fi
}

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
