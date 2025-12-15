# Foot Terminal Configuration
{ config, pkgs, ... }:

{
  programs.foot = {
    enable = true;
    
    # Enable server mode for instant new terminals
    server.enable = true;

    settings = {
      # === Main settings ===
      main = {
        font = "JetBrainsMono Nerd Font:size=12";
        term = "xterm-256color";
        pad = "10x10"; # More padding for a cleaner look
      };

      # === Scrollback ===
      scrollback = {
        lines = 10000; # Increase scrollback buffer
        multiplier = 3.0;
      };

      # === Cursor ===
      cursor = {
        style = "beam";
        blink = true;
      };

      # === Mouse ===
      mouse = {
        hide-when-typing = true;
      };

      # === URLs ===
      url = {
        launch = "xdg-open"; # Use system's default handler to open URLs
        underline = "hover";
      };

      # === Colors (Catppuccin Mocha) ===
      colors = {
        foreground = "cdd6f4"; # Text
        background = "1e1e2e"; # Base
        
        # Regular Colors
        regular0 = "45475a";  # Surface1
        regular1 = "f38ba8";  # Red
        regular2 = "a6e3a1";  # Green
        regular3 = "f9e2af";  # Yellow
        regular4 = "89b4fa";  # Blue
        regular5 = "f5c2e7";  # Pink
        regular6 = "94e2d5";  # Teal
        regular7 = "bac2de";  # Subtext1

        # Bright Colors
        bright0 = "585b70";   # Surface2
        bright1 = "f38ba8";  # Red
        bright2 = "a6e3a1";  # Green
        bright3 = "f9e2af";  # Yellow
        bright4 = "89b4fa";  # Blue
        bright5 = "f5c2e7";  # Pink
        bright6 = "94e2d5";  # Teal
        bright7 = "a6adc8";  # Subtext0
      };

      # === Key Bindings ===
      key-bindings = {
        scrollback-up-page = "Shift+PageUp";
        scrollback-down-page = "Shift+PageDown";
        scrollback-up-line = "Shift+Up";
        scrollback-down-line = "Shift+Down";
        clipboard-copy = "Control+Shift+c";
        clipboard-paste = "Control+Shift+v";
        primary-paste = "Shift+Insert";
        search-start = "Control+Shift+r";
        font-increase = "Control+plus";
        font-decrease = "Control+minus";
        font-reset = "Control+0";
        url-select = "Control+Shift+u";
      };
      
      # === Other settings ===
      # Uncomment if you want foot to have a title bar in tiling mode
      # csd.preferred = "server"; 
    };
  };
}