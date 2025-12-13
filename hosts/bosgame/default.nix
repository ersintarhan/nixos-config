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
    extraGroups = [ "networkmanager" "wheel" "video" "audio" ];
    shell = pkgs.fish;
  };
  security.sudo.wheelNeedsPassword = false;

  # === NIX SETTINGS ===
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
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

  system.stateVersion = "25.11";
}
