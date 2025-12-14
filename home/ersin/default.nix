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

  # === GTK Theme (Dark) ===
  gtk = {
    enable = true;
    theme = {
      name = "Adwaita-dark";
      package = pkgs.gnome-themes-extra;
    };
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };
    cursorTheme = {
      name = "Adwaita";
      package = pkgs.adwaita-icon-theme;
      size = 24;
    };
    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = true;
    };
    gtk4.extraConfig = {
      gtk-application-prefer-dark-theme = true;
    };
  };

  # === Qt Theme (Dark) ===
  qt = {
    enable = true;
    platformTheme.name = "adwaita";
    style = {
      name = "adwaita-dark";
      package = pkgs.adwaita-qt;
    };
  };

  # === Dark mode for apps ===
  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
    };
  };

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
