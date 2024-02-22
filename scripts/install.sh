#!/usr/bin/env sh
message() {
    printf "\n\e[1;37m%s\e[0m\n" "$1"
}

success() {
    printf "\n\033[1;32m✔ %s\033[0m\n" "$1"
}

info() {
    printf "\n\033[0;34mⓘ %s\033[0m\n" "$1"
}

error_exit() {
    printf "\n\033[1;31m✘ %s, exiting.\033[0m\n" "$1"
    exit 1
}

error_clean() {
    printf "\n\033[1;31m✘ %s, removing $HOME/.config and brew then exiting.\033[0m\n" "$1"

    rm -rf "$HOME"/.config /opt/homebrew "$HOME"/.ssh

    exit 1
}

clone_configuration() {
    message "Checking if $HOME/.config already exists..."

    if [ -d "$HOME"/.config ]; then
        error_exit "$HOME/.config already exists"
    else
        git clone https://github.com/mac-codes9/dotfiles "$HOME"/.config
    fi

    success "Configuration cloned successfully"
}

brew_install() {
    message "Installing Hombrew"
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    echo "
    eval "$(/opt/homebrew/bin/brew shellenv)"
    export PATH="$PATH:/opt/homebrew/bin"
    " > "$HOME"/.zprofile
    . "$HOME"/.zprofile
    success "Homebrew installed successfully"
}

tooling_install() {
    message "Installing tooling with Brew..."

    brew install fd fzf gh homebrew/cask/zed hyperkey mas ripgrep rust sd koekeishiya/formulae/skhd koekeishiya/formulae/yabai zig
    mas install 1436953057
    install_doom

    success "Tooling has been installed successfully"
}

configure_git() {
    message "Configuring Git"
    
    echo "
    [user]
	email = maclong9@icloud.com
	name = Mac
    [push]
	default = current
    [init]
	defaultBranch = main
    [merge]
	conflictStyle = zdiff3
    [help]
	autocorrect = 30
    [rebase]
	autosquash = true
    " > ~/.gitconfig
    gh config set git_protocol ssh
    gh auth login
    
    success "Git configured successully"
  }

post_install() {
    message "Configuring tools"
    
    echo "
    yabai -m config layout managed
    yabai -m config top_padding    10
    yabai -m config left_padding   10
    yabai -m config right_padding  10
    yabai -m config window_gap     10
    yabai -m config external_bar main:0:16
    yabai -m config focus_follow_mouse autoraise
    yabai -m rule --add app="^System Settings$" manage=off
    yabai -m rule --add app="^Activity Monitor$" manage=off
    yabai -m rule --add app="^App Store$" manage=off
    yabai -m rule --add app="^Calendar$" manage=off
    yabai -m rule --add app="^Mail$" manage=off
    yabai -m rule --add app="^Reminders$" manage=off
    " > ~/.yabairc 
    
    echo "
    cmd - h : yabai -m window --focus west
    cmd - j : yabai -m window --focus south
    cmd - k : yabai -m window --focus north
    cmd - l : yabai -m window --focus east
    cmd + ctrl - h : yabai -m window --warp west
    cmd + ctrl - j : yabai -m window --warp south
    cmd + ctrl - k : yabai -m window --warp north
    cmd + ctrl - l : yabai -m window --warp east
    cmd + shift - h : yabai -m window --resize left:-15:0; yabai -m window --resize right:-15:0
    cmd + shift - j : yabai -m window --resize bottom:0:15; yabai -m window --resize top:0:15
    cmd + shift - k : yabai -m window --resize top:0:-15; yabai -m window --resize bottom:0:-15
    cmd + shift - l : yabai -m window --resize right:15:0; yabai -m window --resize left:15:0
    cmd + enter : open /Applications/Alacritty.app
    cmd + b : open /Applications/Safari.app
    " > ~/.skhdrc

    yabai --start-service
    skhd --start-service
    configure_git

    success "Post install configuration complete"
}

main() {
    if [ "$(uname -s)" = "Darwin" ]; then
        message "􀣺 Running on macOS"

        clone_configuration || error_clean "Failed to clone configuration repository"
        brew_install || error_clean "Failed to install Homebrew"
        tooling_install || error_clean "Error while installing tooling with homebrew"
        post_install || error_clean "Error during post install configuration"

        success "System configuration complete, enjoy."
    else
        printf "\n\033[1;31m✘ Running on unsupported system, exiting.\033[0m\n"
    fi

    success "Configuration setup completed successfully."
}
main

