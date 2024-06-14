export PATH=$PATH:~/.deno/bin
export PROMPT="%F{white}%n@%m %B%F{brightwhite}%~ 
%F{%(?.blue.red)}%Bλ%b%f "

alias g="git"
alias hg="history | grep"

ws() {
	case "$1" in
		"-s" || "")
            vim -c "cd ${2:-.}" \
                -c "vsplit" \
                -c "Explore | vertical resize 80" \
                -c "wincmd l | Explore |  below terminal";;
        "-w")
            vim -c "cd ${2:-.}" \
                -c "vsplit" \
                -c "wincmd l | Sexplore" \
                -c "wincmd h | vertical resize 80 | terminal" \
                -c "wincmd j | q | wincmd l | wincmd j | Explore";;
    esac
}

