# Desktop Packages
{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # === Terminal ===
    foot
    kitty
    zsh
    starship
    yazi # TUI file manager

    # === Browser ===
    firefox
    microsoft-edge
    brave
    # zen-browser  # Not in nixpkgs yet - can use AppImage

    # === File Manager ===
    nemo-with-extensions
    file-roller

    # === Editor ===
    micro
    zed-editor
    nil # Nix language server
    nixd # Alternative Nix language server
    nixfmt-rfc-style # Nix formatter
    jetbrains-toolbox # JetBrains IDE manager

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

    # .NET (combined SDKs)
    (
      with dotnetCorePackages;
      combinePackages [
        sdk_8_0
        sdk_9_0
        sdk_10_0
      ]
    )

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
    swww # wallpaper

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
    ddcutil # external monitor brightness

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
    sops # Secret management
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
    bat
    zoxide

    # === Polkit Agent ===
    polkit_gnome

    # === XWayland ===
    xwayland-satellite

    # X11 libs (JetBrains IDEs need these)
    xorg.libX11
    xorg.libXext
    xorg.libXi
    xorg.libXrender
    xorg.libXtst

    # === Apps ===
    telegram-desktop
    remmina # Remote desktop client (RDP, VNC, SSH)
    gh # GitHub CLI
    appimage-run # AppImage support
    github-desktop # Git GUI (native)
    gittyup # Git GUI
    lazygit # Terminal Git UI
    youtube-music # Music streaming

    # === HashiCorp ===
    nomad
    consul
    vault # lazım olur

    # === Kubernetes ===
    kubectl
    kubernetes-helm
    k9s # TUI for k8s
    freelens-bin # Kubernetes IDE

    # === AI Tools ===
    amazon-q-cli
    github-copilot-cli
    gh-copilot # gh extension for copilot
  ];
}
