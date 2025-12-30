# Desktop Packages
{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # === Terminal ===
    alacritty
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
    antigravity-fhs # AI IDE (agentic development)
    nil # Nix language server
    nixd # Nix language server
    nixfmt-rfc-style # Nix formatter
    jetbrains-toolbox # JetBrains IDE manager

    # === Development ===
    # Node.js
    nodejs_25
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
    wev # Wayland event viewer (keyboard/mouse input debug)

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
    jq
    unzip
    htop
    mission-center # System monitor (Task Manager style)
    btop
    bpftune # BPF-based auto-tuning
    fastfetch
    xdg-utils
    xdg-user-dirs
    pciutils
    usbutils
    lm_sensors # CPU temperature monitoring
    bat
    zoxide
    p7zip
    bruno
    bruno-cli

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

    # === Email ===
    thunderbird

    # === Apps ===
    telegram-desktop
    remmina # Remote desktop client (RDP, VNC, SSH)
    appimage-run # AppImage support
    github-desktop # Git GUI (native)
    gittyup # Git GUI
    lazygit # Terminal Git UI
    youtube-music # Music streaming
    rustdesk # Remote desktop client (RDP, VNC, SSH)
    onlyoffice-desktopeditors # OnlyOffice document editor

    # === Containers ===
    distrobox # Run any Linux distro in containers
    distrobox-tui # TUI for distrobox
    distroshelf # GUI for distrobox
    boxbuddy # GUI for distrobox (GTK4)
    podman-compose # docker-compose for podman

    # === AI Tools ===
    #
    gh
    github-copilot-cli
    gh-copilot # gh extension for copilot
    python3Packages.huggingface-hub # huggingface-cli for model downloads

    # llama.cpp with Vulkan backend (ROCm has memory fault issues on gfx1151)
    llama-cpp-vulkan
  ];
}
