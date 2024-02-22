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

    brew install hyperkey mas rust visual-studio-code zig
    mas install 1436953057

    success "Tooling has been installed successfully"
}

main() {
    if [ "$(uname -s)" = "Darwin" ]; then
        message "􀣺 Running on macOS"

        clone_configuration || error_clean "Failed to clone configuration repository"
        brew_install || error_clean "Failed to install Homebrew"
        tooling_install || error_clean "Error while installing tooling with homebrew"

        success "System configuration complete, enjoy."
    else
        printf "\n\033[1;31m✘ Running on unsupported system, exiting.\033[0m\n"
    fi

    success "Configuration setup completed successfully."
}
main

