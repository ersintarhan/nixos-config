# Firefox Configuration with Catppuccin theme
{ config, pkgs, ... }:

{
  programs.firefox = {
    enable = true;
    profiles.default = {
      isDefault = true;
      extensions.force = true; # allow catppuccin to manage theme
    };
    # catppuccin theme auto-applied via catppuccin.enable = true
  };
}
