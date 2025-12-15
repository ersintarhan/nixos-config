# Fuzzel Launcher Configuration
{ config, pkgs, ... }:

{
  programs.fuzzel = {
    enable = true;
    settings = {
      main = {
        font = "JetBrains Mono:size=13";
        terminal = "foot";
        layer = "overlay";
        width = 45;
        lines = 10;
        horizontal-pad = 25;
        vertical-pad = 15;
        inner-pad = 8;
        icons-enabled = true;
        icon-theme = "Papirus-Dark";
        prompt = "❯ ";
        letter-spacing = 0.5;
        line-height = 22;
      };
      border = {
        width = 2;
        radius = 12;
      };
    };
  };
}
