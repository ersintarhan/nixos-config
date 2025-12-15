# Desktop Environment (Wayland/Niri)
{ config, pkgs, lib, ... }:

{
  imports = [
    ./niri.nix
    ./waybar.nix
    ./mako.nix
    ./rofi.nix
    ./wallpaper.nix
  ];

  # === GTK Theme ===
  gtk = {
    enable = true;
    theme = {
      name = "Adwaita-dark";
      package = pkgs.gnome-themes-extra;
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

  # === Qt Theme ===
  qt = {
    enable = true;
    platformTheme.name = "kvantum";
    style.name = "kvantum";
  };
}
