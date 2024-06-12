export PATH=$PATH:~/.deno/bin
export PROMPT="%F{white}%n@%m %B%F{brightwhite}%~ 
%F{%(?.blue.red)}%Bλ%b%f "

alias G="git"
alias hg="history | grep"

ws() {
    local mode="study"
    local dir="${1:-.}"

    if [[ "$1" == "-w" || "$1" == "--work" ]]; then
        mode="work"
        dir="${2:-.}"
    elif [[ "$1" == "-s" || "$1" == "--study" ]]; then
        mode="study"
        dir="${2:-.}"
    fi

    case "$mode" in
        "study")
            vim -c "cd $dir" \
                -c "vsplit" \
                -c "Explore | vertical resize 80" \
                -c "wincmd l | Explore |  below terminal"
            ;;
        "work")
            vim -c "cd $dir" \
                -c "vsplit" \
                -c "wincmd l | Sexplore" \
                -c "wincmd h | vertical resize 80 | terminal" \
                -c "wincmd j | q | wincmd l | wincmd j | Explore"
            ;;
    esac
}

