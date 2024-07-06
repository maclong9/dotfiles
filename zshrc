export PATH=$PATH:/opt/homebrew/bin:$HOME/.rbenv/bin:$HOME/Library/pnpm
export PROMPT="%F{white}%n@%m %B%F{brightwhite}%~ 
%F{%(?.blue.red)}%Bλ%b%f "
eval "$(rbenv init -)"
setopt autocd
alias g="git"
alias hg="history | grep"
alias dup="docker-compose up -d"
alias dst="docker-compose stop"
alias ddw="docker-compose down"
