# Dotfiles

These files are used to configure my unix(like) systems, currently the configurations defined in these files are geared towards macOS and Fedora Sericea an immutable linux distribution providing excellent security and stability.

## Usage

Run the following in any Unix terminal.

```
sh -c "$(curl -fsSL https://raw.githubusercontent.com/mac-codes9/dotfiles/main/scripts/install.sh)"
```

> Note: If the script fails to run at any point it will clean up the files that were involved in the setup.

#### Development

The default tools installed on the system are for general usage for development focused workflows ensure that you set up a container using either OrbStack or Toolbox respective of the OS you are running on.
These containers will have access to your home directory so do not run anything destructive in them, use a virtual machine of Qubes OS for experimenting with possibly desctructive scripts and tools.

### Shared

- alacritty
- atuin
- fd
- gh
- neovim
- ripgrep

### macOS

- hyperkey
- mas
- orbstack
- skhd
- utm
- yabai

### Fedora Linux

- aylurs-gtk-shell
- hyprland-git
- hypridle
- hyprlock
- keyd
- swww
- xdg-desktop-portal-hyprland 
