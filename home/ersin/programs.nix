# User Programs Configuration
{ config, pkgs, ... }:

{
  # === Git ===
  programs.git = {
    enable = true;
    lfs.enable = true; # Git LFS
    settings = {
      user.name = "Ersin Tarhan";
      user.email = "ersintarhan@gmail.com";
      user.signingkey = "4D31F871BF61EB98";
      commit.gpgsign = true;
      tag.gpgsign = true;
      init.defaultBranch = "main";
      pull.rebase = false;
    };
  };

  # === Environment Variables ===
  home.sessionVariables = {
    CONSUL_HTTP_ADDR = "http://10.101.1.11:8500";
    NOMAD_ADDR = "http://10.101.1.21:4646";
  };

  # === Fish ===
  programs.fish = {
    enable = true;
    shellAbbrs = {
      ll = "ls -la";
      update = "sudo nixos-rebuild switch --flake ~/nixos-config#bosgame";
      cleanup = "sudo nix-collect-garbage -d";
      gs = "git status";
      gp = "git push";
      cat = "bat"; # bat as cat replacement
    };
    interactiveShellInit = ''
      set -g fish_greeting  # Disable greeting
    '';
  };

  # === Zoxide (smart cd) ===
  programs.zoxide = {
    enable = true;
    enableFishIntegration = true;
  };

  # === Bat (better cat) ===
  programs.bat = {
    enable = true;
    config = {
      theme = "Catppuccin Mocha";
      style = "numbers,changes";
    };
  };

  # === Starship Prompt ===
  programs.starship = {
    enable = true;
    enableFishIntegration = true;
  };

  # === Kitty Terminal ===
  programs.kitty = {
    enable = true;
    settings = {
      # Font
      font_family = "JetBrains Mono";
      bold_font = "JetBrains Mono Bold";
      italic_font = "JetBrains Mono Italic";
      font_size = 12;

      # Window
      background_opacity = "0.95";
      window_padding_width = 8;
      confirm_os_window_close = 0;
      remember_window_size = true;
      hide_window_decorations = true;

      # Tabs
      tab_bar_edge = "top";
      tab_bar_style = "powerline";
      tab_powerline_style = "slanted";
      tab_title_template = "{index}: {title}";
      active_tab_font_style = "bold";

      # Mouse & Selection
      copy_on_select = "clipboard";
      mouse_map = "left click ungrabbed mouse_handle_click selection link prompt";
      open_url_with = "default";
      url_style = "curly";
      detect_urls = true;
      underline_hyperlinks = "hover";

      # Cursor
      cursor_shape = "beam";
      cursor_blink_interval = "0.5";

      # Bell
      enable_audio_bell = false;
      visual_bell_duration = "0.0";

      # Scrollback
      scrollback_lines = 10000;

      # Colors (Catppuccin Mocha)
      foreground = "#CDD6F4";
      background = "#1E1E2E";
      selection_foreground = "#1E1E2E";
      selection_background = "#F5E0DC";
      cursor = "#F5E0DC";
      cursor_text_color = "#1E1E2E";
      url_color = "#F5E0DC";

      # Tab bar colors
      active_tab_foreground = "#11111B";
      active_tab_background = "#CBA6F7";
      inactive_tab_foreground = "#CDD6F4";
      inactive_tab_background = "#181825";

      # Normal colors
      color0 = "#45475A";
      color1 = "#F38BA8";
      color2 = "#A6E3A1";
      color3 = "#F9E2AF";
      color4 = "#89B4FA";
      color5 = "#F5C2E7";
      color6 = "#94E2D5";
      color7 = "#BAC2DE";

      # Bright colors
      color8 = "#585B70";
      color9 = "#F38BA8";
      color10 = "#A6E3A1";
      color11 = "#F9E2AF";
      color12 = "#89B4FA";
      color13 = "#F5C2E7";
      color14 = "#94E2D5";
      color15 = "#A6ADC8";
    };
    keybindings = {
      "ctrl+shift+t" = "new_tab";
      "ctrl+shift+w" = "close_tab";
      "ctrl+shift+right" = "next_tab";
      "ctrl+shift+left" = "previous_tab";
      "ctrl+shift+." = "move_tab_forward";
      "ctrl+shift+," = "move_tab_backward";
      "ctrl+shift+c" = "copy_to_clipboard";
      "ctrl+shift+v" = "paste_from_clipboard";
      "ctrl+shift+enter" = "new_window";
      "ctrl+shift+plus" = "change_font_size all +1.0";
      "ctrl+shift+minus" = "change_font_size all -1.0";
      "ctrl+shift+backspace" = "change_font_size all 0";
    };
  };

  # === Foot Terminal ===
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

  # === Yazi File Manager ===
  programs.yazi = {
    enable = true;
    enableFishIntegration = true;
  };

  # === Btop ===
  programs.btop = {
    enable = true;
    settings = {
      theme_background = false;
      vim_keys = true;
    };
  };

  # === Fastfetch ===
  programs.fastfetch = {
    enable = true;
  };

  # === Direnv (auto-load dev environments) ===
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true; # Faster nix integration
  };

  # === SSH ===
  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;
    matchBlocks = {
      "*" = {
        extraOptions = {
          SendEnv = "-LC_*";
          SetEnv = "LC_ALL=C";
          ConnectTimeout = "10";
          ServerAliveInterval = "60";
          ServerAliveCountMax = "3";
        };
      };
      "github.com" = {
        hostname = "github.com";
        user = "git";
        identityFile = "~/.ssh/id_ed25519";
      };
      "internal" = {
        host = "10.* 192.168.* *.consul *.zone";
        user = "root";
        extraOptions = {
          ConnectTimeout = "5";
          StrictHostKeyChecking = "no";
          UserKnownHostsFile = "/dev/null";
        };
        identityFile = "~/.ssh/id_rsa";
      };
    };
  };

  # === GitHub Desktop Plus (AppImage) ===
  home.file.".local/bin/github-desktop-plus" = {
    executable = true;
    text = ''
      #!/usr/bin/env bash
      exec appimage-run ~/.local/bin/github-desktop-plus.AppImage "$@"
    '';
  };

  xdg.desktopEntries.github-desktop-plus = {
    name = "GitHub Desktop Plus";
    genericName = "Git Client";
    exec = "github-desktop-plus %U";
    icon = "github";
    terminal = false;
    categories = [
      "Development"
      "RevisionControl"
    ];
    mimeType = [
      "x-scheme-handler/x-github-client"
      "x-scheme-handler/github-mac"
    ];
  };

  # === GPG ===
  programs.gpg.enable = true;
  services.gpg-agent = {
    enable = true;
    pinentry.package = pkgs.pinentry-gnome3;
    enableSshSupport = true;
  };
}
