# Catppuccin Theme Configuration
{ config, pkgs, ... }:

{
  # Global catppuccin settings
  catppuccin = {
    enable = true;
    flavor = "mocha";    # mocha, macchiato, frappe, latte
    accent = "lavender"; # rosewater, flamingo, pink, mauve, red, maroon, peach, yellow, green, teal, sky, sapphire, blue, lavender
  };

  # Per-app catppuccin (these are auto-enabled when catppuccin.enable = true)
  # But you can customize or disable specific ones:
  # catppuccin.bat.enable = true;
  # catppuccin.btop.enable = true;
  # catppuccin.fish.enable = true;
  # catppuccin.starship.enable = true;
  # catppuccin.kitty.enable = true;
  # catppuccin.foot.enable = true;
  # catppuccin.gtk.enable = true;
  # catppuccin.mako.enable = true;
  # catppuccin.waybar.enable = true;
}
