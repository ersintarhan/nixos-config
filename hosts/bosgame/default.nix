# Bosgame Host Configuration
{ config, pkgs, ... }:

{
  imports = [
    ./hardware.nix
    ../../modules/desktop
    ../../modules/development/dotnet.nix # .NET SDK + global tools
    ../../modules/development/python.nix # Python + uv
    ../../modules/development/ai-tools.nix # Codex CLI + ACP
    ../../modules/development/database.nix # Database tools
    ../../modules/development/cloud.nix # Cloud tools
    ../../modules/services/audio.nix
    ../../modules/services/bluetooth.nix
    ../../modules/services/dns.nix # Split DNS (Consul + Cloudflare)
    ../../modules/hardware/graphics.nix
  ];

  # === BOOT ===
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.kernelModules = [
    "i2c-dev"
    "amdgpu"
  ]; # For ddcutil + ROCm
  boot.kernelParams = [
    "amd_iommu=off" # ROCm memory access için
  ];

  # === ZRAM (compressed RAM swap) ===
  zramSwap = {
    enable = true;
    memoryPercent = 50; # 32GB zram
  };

  # === DDC/CI (external monitor control) ===
  hardware.i2c.enable = true;

  # === NETWORK ===
  networking.hostName = "bosgame";
  networking.networkmanager.enable = true;
  # DNS is managed by ../../modules/services/dns.nix (split DNS: Consul + Cloudflare)

  # === LOCALE & TIME ===
  time.timeZone = "Europe/Istanbul";
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "tr_TR.UTF-8";
    LC_IDENTIFICATION = "tr_TR.UTF-8";
    LC_MEASUREMENT = "tr_TR.UTF-8";
    LC_MONETARY = "tr_TR.UTF-8";
    LC_NAME = "tr_TR.UTF-8";
    LC_NUMERIC = "tr_TR.UTF-8";
    LC_PAPER = "tr_TR.UTF-8";
    LC_TELEPHONE = "tr_TR.UTF-8";
    LC_TIME = "tr_TR.UTF-8";
  };

  # === USER ===
  programs.fish.enable = true;
  users.users.ersin = {
    isNormalUser = true;
    description = "Ersin Tarhan";
    extraGroups = [
      "networkmanager"
      "wheel"
      "video"
      "render" # For ROCm GPU compute
      "audio"
      "i2c" # For ddcutil (monitor brightness)
    ];
    shell = pkgs.fish;

  };
  security.sudo.wheelNeedsPassword = false;

  # === BPFTUNE (auto-tune system with BPF) ===
  services.bpftune.enable = true;

  # === PODMAN (container runtime) ===
  virtualisation.podman = {
    enable = true;
    dockerCompat = true; # docker alias
    defaultNetwork.settings.dns_enabled = true;
  };

  # === NIX-LD (for proprietary binaries like JetBrains) ===
  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
    # X11 libs for JetBrains
    xorg.libX11
    xorg.libXext
    xorg.libXi
    xorg.libXrender
    xorg.libXtst
    xorg.libXcursor
    xorg.libXrandr
    xorg.libXfixes
    xorg.libXinerama
    xorg.libXxf86vm
    # Other common libs
    libGL
    libxkbcommon
    fontconfig
    freetype
    zlib
    glib
    icu
    openssl
    stdenv.cc.cc.lib
  ];

  # === NIX SETTINGS ===
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };
  nixpkgs.config.allowUnfree = true;

  # === SERVICES ===
  services.openssh.enable = true;
  services.gvfs.enable = true;
  services.udisks2.enable = true;
  services.flatpak.enable = true;

  # Flatpak & local apps visible in launcher
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  environment.sessionVariables = {
    XDG_DATA_DIRS = [
      "$HOME/.local/share"
      "/var/lib/flatpak/exports/share"
      "$HOME/.local/share/flatpak/exports/share"
    ];
    # JetBrains IDEs on Wayland
    _JAVA_AWT_WM_NONREPARENTING = "1";
  };

  system.stateVersion = "25.11";
}
