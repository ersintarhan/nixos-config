# Micro Editor Configuration with Catppuccin theme
{ config, pkgs, ... }:

{
  programs.micro = {
    enable = true;
    settings = {
      autosu = true;
      mkparents = true;
      savecursor = true;
      scrollbar = true;
      tabsize = 2;
      tabstospaces = true;
    };
    # catppuccin theme auto-applied via catppuccin.enable = true
  };
}
