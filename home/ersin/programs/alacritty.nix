# Alacritty Terminal Configuration
{ config, pkgs, ... }:

{
  programs.alacritty = {
    enable = true;
    settings = {
      # Environment variables for Wayland
      env.WINIT_X11_SCALE_FACTOR = "1.0";

      # Window settings
      window = {
        padding = { x = 10; y = 10; };
        dynamic_padding = false;
        decorations = "none"; # No title bar
        opacity = 0.95;
      };

      # Scrolling
      scrolling.history = 10000;

      # Font settings
      font = {
        normal = {
          family = "JetBrainsMono Nerd Font";
          style = "Regular";
        };
        bold = {
          family = "JetBrainsMono Nerd Font";
          style = "Bold";
        };
        italic = {
          family = "JetBrainsMono Nerd Font";
          style = "Italic";
        };
        size = 12;
      };

      # Colors (Catppuccin Mocha)
      colors = {
        primary = {
          background = "#1e1e2e"; # Base
          foreground = "#cdd6f4"; # Text
        };
        normal = {
          black = "#45475a";
          red = "#f38ba8";
          green = "#a6e3a1";
          yellow = "#f9e2af";
          blue = "#89b4fa";
          magenta = "#f5c2e7";
          cyan = "#94e2d5";
          white = "#bac2de";
        };
        bright = {
          black = "#585b70";
          red = "#f38ba8";
          green = "#a6e3a1";
          yellow = "#f9e2af";
          blue = "#89b4fa";
          magenta = "#f5c2e7";
          cyan = "#94e2d5";
          white = "#a6adc8";
        };
      };

      # Key bindings
      key_bindings = [
        { key = "V"; mods = "Control|Shift"; action = "Paste"; }
        { key = "C"; mods = "Control|Shift"; action = "Copy"; }
        { key = "PageUp"; mods = "Shift"; action = "ScrollPageUp"; }
        { key = "PageDown"; mods = "Shift"; action = "ScrollPageDown"; }
        { key = "Home"; mods = "Shift"; action = "ScrollToTop"; }
        { key = "End"; mods = "Shift"; action = "ScrollToBottom"; }
      ];

      # Mouse settings
      mouse = {
        hide_when_typing = true;
      };
      
      # Selection settings for copy-on-select
      selection.save_to_clipboard = true;
    };
  };
}
