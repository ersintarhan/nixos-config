# Starship Prompt Configuration
{ config, pkgs, ... }:

{
  programs.starship = {
    enable = true;
    enableFishIntegration = true; # Ensures starship works with fish
    
    settings = {
      # Overall prompt format
      format = "$env_var$username$hostname$shell$directory$git_branch$git_status$nodejs$python$rust$dotnet$nix_shell$cmd_duration$line_break$character";
      
      # Remove the newline between prompt and command for a compact look
      add_newline = false;

      # User@Host format
      username = {
        show_always = true;
        style_user = "bold #FAB387"; # Peach
        style_root = "bold #F38BA8"; # Red
        format = "[$user]($style)";
      };

      hostname = {
        ssh_only = false;
        style = "bold #F9E2AF"; # Yellow
        format = "@[$hostname]($style) "; # Added space for separation
      };
      
      shell = {
        disabled = false;
        fish_indicator = "󰈺 "; # Fish icon
        bash_indicator = "󰘳 "; # Bash icon
        zsh_indicator = " "; # Zsh icon
        style = "bold #89B4FA"; # Blue
        format = "[$indicator]($style)";
      };

      # Directory settings
      directory = {
        home_symbol = ""; # Home icon
        truncation_length = 3;
        truncation_symbol = "…/";
        read_only_style = "bold #F38BA8"; # Red
        read_only = " 󰌾"; # Lock icon
        style = "bold #B4BEFE"; # Lavender (directory color)
        format = "in [$path]($style)[$read_only]($read_only_style) ";
      };

      # Git branch settings
      git_branch = {
        symbol = " "; # Branch icon (Octicons)
        style = "bold #A6E3A1"; # Green
        format = "on [$symbol$branch(:$remote_branch)]($style)";
      };

      # Git status settings
      git_status = {
        staged = "[+$count](#A6E3A1)"; # Green
        modified = "[!$count](#F9E2AF)"; # Yellow
        untracked = "[?$count](#F38BA8)"; # Red
        deleted = "[x$count](#F38BA8)"; # Red
        renamed = "[>$count](#89B4FA)"; # Blue
        ahead = "⇡$count";
        behind = "⇣$count";
        diverged = "⇕$ahead$behind";
        up_to_date = "";
        conflicted = "[=$count](#F38BA8)"; # Red
        style = "bold #F38BA8"; # Red
        format = "([$staged$modified$untracked$deleted$renamed$conflicted$ahead_behind$untracked_files])";
      };

      # Command duration
      cmd_duration = {
        min_time = 500; #ms
        format = " took [$duration](bold #94E2D5)"; # Teal
      };

      # Prompt character
      character = {
        success_symbol = "[❯](bold #A6E3A1)"; # Green arrow
        error_symbol = "[❯](bold #F38BA8)"; # Red arrow
        vicmd_symbol = "[❮](bold #89B4FA)"; # Blue arrow for Vi-mode
      };

      # Language modules (show only when detected)
      nodejs = {
        symbol = " "; # Node.js icon
        format = "via [$symbol($version)]($style) ";
        style = "bold #A6E3A1"; # Green
      };
      
      python = {
        symbol = " "; # Python icon
        format = "via [$symbol($version)]($style) ";
        style = "bold #89B4FA"; # Blue
      };

      rust = {
        symbol = " "; # Rust icon
        format = "via [$symbol($version)]($style) ";
        style = "bold #EBA0AC"; # Maroon
      };

      dotnet = {
        symbol = "󰲠 "; # .NET icon
        format = "via [$symbol($version)]($style) ";
        style = "bold #CBA6F7"; # Mauve
      };

      # Nix-shell / Flake indicator
      nix_shell = {
        symbol = "❄️ "; # Snowflake icon
        format = "[$symbol]($style)";
        style = "bold #89B4FA"; # Blue
      };
    };
  };
}
