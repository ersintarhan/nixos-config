# Vivid - LS_COLORS generator with catppuccin theme
{ config, pkgs, ... }:

{
  programs.vivid = {
    enable = true;
    enableFishIntegration = true;
    # catppuccin theme auto-applied via catppuccin.enable = true
  };
}
