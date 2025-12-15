# Eza - Modern ls replacement with catppuccin theme
{ config, pkgs, ... }:

{
  programs.eza = {
    enable = true;
    icons = "auto";
    git = true;
    extraOptions = [
      "--group-directories-first"
    ];
    # catppuccin theme auto-applied via catppuccin.enable = true
  };
}
