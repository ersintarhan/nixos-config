# Anyrun Launcher Configuration
{ config, pkgs, inputs, ... }:

{
  programs.anyrun = {
    enable = true;

    config = {
      plugins = with inputs.anyrun.packages.${pkgs.system}; [
        applications    # App launcher
        rink           # Calculator (unit conversion too!)
        shell          # Run shell commands
        symbols        # Unicode symbols
        niri-focus     # Niri window switcher
      ];

      width = { fraction = 0.35; };
      height = { absolute = 0; };
      hideIcons = false;
      ignoreExclusiveZones = false;
      layer = "overlay";
      hidePluginInfo = false;
      closeOnClick = true;
      showResultsImmediately = false;
      maxEntries = 10;
    };

    # Catppuccin Mocha styling
    extraCss = ''
      * {
        all: unset;
        font-family: "JetBrains Mono", monospace;
        font-size: 14px;
      }

      #window {
        background: transparent;
      }

      #main {
        background: #1e1e2e;
        border: 2px solid #b4befe;
        border-radius: 12px;
        padding: 8px;
      }

      #entry {
        background: #313244;
        border-radius: 8px;
        padding: 12px 16px;
        margin-bottom: 8px;
        color: #cdd6f4;
        caret-color: #b4befe;
      }

      #entry:focus {
        border: 1px solid #b4befe;
      }

      #plugin {
        padding: 4px;
      }

      #match {
        padding: 8px 12px;
        border-radius: 8px;
        color: #cdd6f4;
      }

      #match:hover {
        background: #313244;
      }

      #match:selected {
        background: #45475a;
        color: #cdd6f4;
      }

      #match-title {
        color: #cdd6f4;
        font-weight: bold;
      }

      #match-desc {
        color: #a6adc8;
        font-size: 12px;
      }
    '';
  };
}
