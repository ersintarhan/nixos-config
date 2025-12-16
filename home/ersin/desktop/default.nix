# Desktop Environment (Wayland/Niri)
{ config, pkgs, lib, ... }:

{
  # === Cursor Theme (system-wide for Wayland) ===
  home.pointerCursor = {
    name = "Bibata-Modern-Classic";
    package = pkgs.bibata-cursors;
    size = 24;
    gtk.enable = true;
    x11.enable = true;
  };

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
      name = "Bibata-Modern-Classic";
      package = pkgs.bibata-cursors;
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
