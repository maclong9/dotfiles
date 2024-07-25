export PATH=$PATH:/opt/homebrew/bin
export PROMPT="%F{white}%n@%m %B%F{brightwhite}%~ 
%F{%(?.blue.red)}%Bλ%b%f "

setopt autocd

alias g="git"
alias hg="history | grep"
alias dup="docker-compose up -d"
alias dst="docker-compose stop"
alias ddw="docker-compose down"
alias ls="sls -cli"
alias ytad="yt-dlp -x --audio-format alac"
alias setupinstall="brew install deno gh neovim tmux zoxide && brew install --cask clop heroix maccy neovide orbstack visual-studio-code whisky"

source ~/.zplug/init.zsh
zplug "zsh-users/zsh-syntax-highlighting"
zplug "zsh-users/zsh-completions"
zplug "kjhaber/tm.zsh"
zplug "ajeetdsouza/zoxide"
zplug "zplug/zplug", hook-build:"zplug --self-manage"
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi
zplug load

# bun completions
[ -s "/Users/maclong/.bun/_bun" ] && source "/Users/maclong/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion


# pnpm
export PNPM_HOME="/Users/maclong/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end
