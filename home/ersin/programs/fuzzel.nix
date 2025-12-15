# Fuzzel Launcher Configuration
{ config, pkgs, ... }:

{
  programs.fuzzel = {
    enable = true;
    settings = {
      main = {
        font = "JetBrains Mono:size=12";
        terminal = "foot";
        layer = "overlay";
        width = 35;
        lines = 12;
        horizontal-pad = 20;
        vertical-pad = 10;
        inner-pad = 5;
      };
      border = {
        width = 2;
        radius = 10;
      };
    };
  };
}
