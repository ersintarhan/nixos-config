# Mako Notification Configuration (Home Manager)
{ config, pkgs, ... }:

{
  services.mako = {
    enable = true;

    settings = {
      # Appearance
      font = "JetBrains Mono 11";
      background-color = "#1e1e2eee";
      text-color = "#cdd6f4";
      border-color = "#89b4fa";
      border-radius = 8;
      border-size = 2;
      padding = "12";
      margin = "10";

      # Position
      anchor = "top-right";
      width = 350;
      height = 150;

      # Behavior
      default-timeout = 5000;
      max-visible = 5;
      layer = "overlay";

      # Icons
      icons = true;
      max-icon-size = 48;
    };

    extraConfig = ''
      [urgency=low]
      border-color=#6c7086

      [urgency=normal]
      border-color=#89b4fa

      [urgency=critical]
      border-color=#f38ba8
      default-timeout=0
    '';
  };
}
