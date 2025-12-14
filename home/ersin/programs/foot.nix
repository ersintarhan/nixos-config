# Foot Terminal Configuration
{ config, pkgs, ... }:

{
  programs.foot = {
    enable = true;
    settings = {
      main = {
        font = "JetBrains Mono:size=11";
        pad = "8x8";
      };
      colors = {
        background = "1e1e2e";
        foreground = "cdd6f4";
      };
    };
  };
}
