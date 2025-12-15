# K9s Configuration (theme only, binary loaded on-demand via fish function)
{ config, pkgs, ... }:

{
  programs.k9s = {
    enable = true;
    # catppuccin theme is auto-applied via catppuccin.enable = true
  };
}
