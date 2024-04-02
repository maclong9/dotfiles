export PATH="$PATH:$HOME/.deno/bin/"
export PROMPT="%F{white}%n@%m %B%F{brightwhite}%~ 
%F{%(?.blue.red)}%B󰘧%b%f "

alias g="git"

mkcd() {
  mkdir "$1" && cd "$1"
}

gc() {
	if [[ "$1" == *"https"* ]]; then
		git clone "$1"
	else
		base_url="https://github.com"
		if [[ "$1" == *"/"* ]]; then
			git clone "$base_url/$1"
		else
			git clone "$base_url/maclong9/$1"
		fi
	fi
}
