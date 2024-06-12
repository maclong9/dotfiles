export PATH=$PATH:~/.deno/bin
export PROMPT="%F{white}%n@%m %B%F{brightwhite}%~ 
%F{%(?.blue.red)}%Bλ%b%f "

alias G="git"
alias hg="history | grep"

# Study Space
ss() {
	vim -c "cd ${1:-.}" \
		-c "vsplit" \
		-c "Explore | vertical resize 80" \
		-c "wincmd l | Explore |  below terminal" 
}

# Work Space
ws() {
	vim -c "cd ${1:-.}" \
		-c "vsplit" \
		-c "wincmd l | Sexplore" \
		-c "wincmd h | vertical resize 80 | terminal" \
		-c "wincmd j | q | wincmd l | wincmd j | Explore"
}

