# Rofi Launcher Configuration (Wayland)
{ config, pkgs, ... }:

{
  programs.rofi = {
    enable = true;
    # rofi-wayland merged into rofi

    plugins = with pkgs; [
      rofi-calc      # Calculator
      rofi-emoji     # Emoji picker
    ];

    extraConfig = {
      modi = "drun,run,calc,emoji";
      show-icons = true;
      icon-theme = "Papirus-Dark";
      terminal = "foot";
      drun-display-format = "{name}";
      disable-history = false;
      sorting-method = "fzf";
    };

    theme = let
      inherit (config.lib.formats.rasi) mkLiteral;
    in {
      "*" = {
        bg = mkLiteral "#1e1e2e";
        bg-alt = mkLiteral "#313244";
        fg = mkLiteral "#cdd6f4";
        fg-alt = mkLiteral "#a6adc8";
        accent = mkLiteral "#b4befe";

        background-color = mkLiteral "@bg";
        text-color = mkLiteral "@fg";
        font = "JetBrains Mono 13";
      };

      window = {
        width = mkLiteral "35%";
        padding = mkLiteral "20px";
        border = mkLiteral "2px";
        border-color = mkLiteral "@accent";
        border-radius = mkLiteral "12px";
      };

      inputbar = {
        padding = mkLiteral "12px 16px";
        background-color = mkLiteral "@bg-alt";
        border-radius = mkLiteral "8px";
        margin = mkLiteral "0 0 10px 0";
        children = map mkLiteral [ "prompt" "entry" ];
      };

      prompt = {
        text-color = mkLiteral "@accent";
        margin = mkLiteral "0 10px 0 0";
      };

      entry = {
        placeholder = "Search...";
        placeholder-color = mkLiteral "@fg-alt";
      };

      listview = {
        lines = 8;
        columns = 1;
        spacing = mkLiteral "5px";
        scrollbar = false;
      };

      element = {
        padding = mkLiteral "10px 12px";
        border-radius = mkLiteral "8px";
      };

      "element selected" = {
        background-color = mkLiteral "@bg-alt";
      };

      element-icon = {
        size = mkLiteral "24px";
        margin = mkLiteral "0 10px 0 0";
      };

      element-text = {
        vertical-align = mkLiteral "0.5";
      };
    };
  };
}
