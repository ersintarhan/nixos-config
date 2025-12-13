# Desktop Packages
{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # === Terminal ===
    foot
    kitty
    zsh
    starship
    yazi  # TUI file manager

    # === Browser ===
    firefox

    # === File Manager ===
    nemo-with-extensions
    file-roller

    # === Editor ===
    micro
    zed-editor
    nil  # Nix language server
    nixd  # Alternative Nix language server
    nixfmt-rfc-style  # Nix formatter

    # === Development ===
    # Node.js
    nodejs_22
    pnpm
    yarn

    # Rust
    rustc
    cargo
    rust-analyzer

    # Python
    python3
    python3Packages.pip

    # Build tools
    gcc
    gnumake
    pkg-config

    # === Wayland Essentials ===
    waybar
    mako
    fuzzel
    wofi
    wl-clipboard
    cliphist
    swaylock-effects
    swayidle
    wlogout
    swww  # wallpaper

    # === Screenshot & Recording ===
    grim
    slurp
    swappy
    wf-recorder

    # === Media ===
    imv
    mpv
    pavucontrol
    pamixer
    playerctl

    # === Brightness ===
    brightnessctl
    ddcutil  # external monitor brightness

    # === Network ===
    networkmanagerapplet

    # === Bluetooth ===
    bluez
    bluez-tools

    # === Theme & Appearance ===
    adwaita-icon-theme
    papirus-icon-theme
    gnome-themes-extra
    gtk3
    gtk4
    libadwaita
    qt5.qtwayland
    qt6.qtwayland

    # === Utils ===
    git
    gnupg
    pinentry-gnome3
    curl
    wget
    unzip
    htop
    btop
    fastfetch
    xdg-utils
    xdg-user-dirs
    pciutils
    usbutils

    # === Polkit Agent ===
    polkit_gnome

    # === XWayland ===
    xwayland-satellite

    # === Apps ===
    telegram-desktop
  ];
}
