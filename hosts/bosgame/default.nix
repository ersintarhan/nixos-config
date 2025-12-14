# Bosgame Host Configuration
{ config, pkgs, ... }:

{
  imports = [
    ./hardware.nix
    ../../modules/desktop
    ../../modules/services/audio.nix
    ../../modules/services/bluetooth.nix
    ../../modules/hardware/graphics.nix
  ];

  # === BOOT ===
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # === NETWORK ===
  networking.hostName = "bosgame";
  networking.networkmanager.enable = true;

  # === DNS (Consul) ===
  networking.nameservers = [
    "10.101.1.11"
    "10.101.1.12"
    "10.101.1.13"
  ];
  networking.search = [
    "consul"
    "node.consul"
    "service.consul"
  ];
  networking.networkmanager.dns = "none"; # NM DNS'i yönetmesin

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
      "audio"
    ];
    shell = pkgs.fish;
  };
  security.sudo.wheelNeedsPassword = false;

  # === BPFTUNE (auto-tune system with BPF) ===
  services.bpftune.enable = true;

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
    XDG_DATA_DIRS = [ "$HOME/.local/share" "/var/lib/flatpak/exports/share" "$HOME/.local/share/flatpak/exports/share" ];
    # JetBrains IDEs on Wayland
    _JAVA_AWT_WM_NONREPARENTING = "1";
  };

  system.stateVersion = "25.11";
}
