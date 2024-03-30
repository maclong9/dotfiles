# Dotfiles

The setup script is POSIX compliant but requires `git` & `curl` installed. If you are on
macOS `curl` is installed as a default and the script will automatically install 
Xcode Command Line Tools so `git` will be installed. On other POSIX compliant systems 
ensure you have at least the above tools before running the script.

```sh
curl https://raw.githubusercontent.com/maclong9/dotfiles/main/setup.sh | sh
```

## ZSH

Mostly to set the `PATH` and `PROMPT` variables, colour of prompt symbol will change 
dependant on the exit code of the previous command. Otherwise just a few aliases and 
functions.

## Vim

Keeping this as minimal as possible, avoiding installing any plugins to start with to see
how much can actually be done with just Vim on it's own... The answer is quite a lot actually.
It even has completions built in from the get go that will scan the current working directory
for possible completions.

There is also the templates folder which will be used by the `templates` augroup in the Vim
configuration. This saves me from typing out repetitive boilerplate for commonly used
filetypes.

## Git 

Sets user information to begin with, I have also chosen to define all of my Git related 
aliases as Git aliases rather than shell aliases. This allows them to be used perfectly
with the command `:G <args>` defined in my Vim configuration, example usage below.

``` vim
:G ac "feat: added explanation of tools" <cr>
``` 
