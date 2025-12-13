# Home Manager Configuration for Ersin
{ config, pkgs, ... }:

{
  imports = [
    ./programs.nix
    ./niri.nix
    ./waybar.nix
    ./mako.nix
  ];

  home.username = "ersin";
  home.homeDirectory = "/home/ersin";

  # Let Home Manager manage itself
  programs.home-manager.enable = true;

  # User packages (GUI apps etc.)
  home.packages = with pkgs; [
    # Add user-specific packages here
  ];

  # XDG directories
  xdg.enable = true;
  xdg.userDirs = {
    enable = true;
    createDirectories = true;
    desktop = "${config.home.homeDirectory}/Desktop";
    documents = "${config.home.homeDirectory}/Documents";
    download = "${config.home.homeDirectory}/Downloads";
    music = "${config.home.homeDirectory}/Music";
    pictures = "${config.home.homeDirectory}/Pictures";
    videos = "${config.home.homeDirectory}/Videos";
  };

  home.stateVersion = "25.11";
}
