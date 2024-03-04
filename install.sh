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
    printf "\n\033[1;31m✘ %s, script related tools and dirs have not been removed, exiting.\033[0m\n" "$1"
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
    message "Installing Homebrew"
    
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    echo "
    eval "$(/opt/homebrew/bin/brew shellenv)"
    export PATH="$PATH:/opt/homebrew/bin"
    " > "$HOME"/.zprofile
    . "$HOME"/.zprofile
    
    success "Homebrew installed successfully"
}

astro_install() {
    message "Installing AstroNvim..."
    
    git clone --depth 1 https://github.com/AstroNvim/AstroNvim ~/.config/nvim
    mkdir -p ~/.config/nvim/lua/user
    ln -s ~/.config/astro.lua ~/.config/nvim/lua/user/init.lua

    success "AstroNvim has been installed successfully"
}

tooling_install() {
    message "Installing tooling..."
    
    if [ "$1" = "mac" ]; then
        brew tap koekeishiya/formulae
        brew install alacritty atuin fd gh hyperkey mas neovim orbstack ripgrep skhd utm yabai
        mas install 1436953057
        astro_install
    elif [ "$1" = "fedora" ]; then
        sudo dnf copr enable alternateved/keyd solopasha/hyprland sramanujam/atuin
        sudo dnf install atuin aylurs-gtk-shell alacritty fd-find gh grim keyd neovim ripgrep slurp

        if [ "$window_manager" = "hyprland" ]; then
            sudo dnf install hyprland-git hypridle hyprlock swww xdg-desktop-portal-hyprland
        else if [ "$window_manager" = "sway" ]; then
            sudo dnf install sway swaylock sway
        fi
        
        sudo systemctl enable keyd && sudo systemctl start keyd
        sudo curl https://gist.githubusercontent.com/mac-codes9/cdf1d5bea296d29bc3a22b0c8980eed0/raw/347f8f38a1c19a4873e98c5f28c9bdd2d67c20a8/keyd > /etc/keyd/default.conf
        curl https://gist.githubusercontent.com/mac-codes9/cdf1d5bea296d29bc3a22b0c8980eed0/raw/9b59ca92f99f4e453866bed80869bf5def551b08/alacritty > ~/.config/alacritty/alacritty.toml
        curl https://gruvbox-wallpapers.pages.dev/wallpapers/minimalistic/gruv.jpg -o ~/Pictures/wallpaper.jpg
        astro_install
    fi
    success "Tooling has been installed successfully"
}

post_install() {
    gh auth login
    atuin register -u mac-codes9 -e maclong9@icloud.com
}

select_window_manager() {
    PS3="Please select your window manager: "
    options=("sway" "hyprland")
    select opt in "${options[@]}"; do
        case $opt in
            "sway")
                window_manager="sway"
                break
                ;;
            "hyprland")
                window_manager="hyprland"
                break
                ;;
            *) echo "Invalid option. Please select again.";;
        esac
    done
}

main() {
    while [ "$#" -gt 0 ]; do
        case "$1" in
            --window-manager|-w)
                shift
                window_manager="$1"
                ;;
            *)
                printf "Unknown option: %s\n" "$1"
                exit 1
                ;;
        esac
        shift
    done


    if [ -z "$window_manager" ]; then
        printf "Window manager not specified. Please choose between 'sway' or 'hyprland': "
        read -r window_manager
    fi

    clone_configuration || error_clean "Failed to clone configuration repository"
    
    if [ "$(uname -s)" = "Darwin" ]; then
        message "􀣺 Running on macOS"
        brew_install || error_clean "Failed to install Homebrew"
        tooling_install "mac" || error_exit "Error while installing tooling with homebrew"
    elif [ "$(lsb_release -a)" = "Fedora" ]; then
            tooling_install "fedora" || error_clean "Error while installing tooling with sway"
    else
        printf "\n\033[1;31m✘ Running on unsupported system, exiting.\033[0m\n"
        exit 1
    fi

    post_install || error_exit "Error while running post-install configuration"
    success "Configuration setup completed successfully."
}

main "$@"
