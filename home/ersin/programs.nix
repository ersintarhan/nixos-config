# User Programs Configuration
{ config, pkgs, ... }:

{
  # === Git ===
  programs.git = {
    enable = true;
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

  # === Fish ===
  programs.fish = {
    enable = true;
    shellAbbrs = {
      ll = "ls -la";
      update = "sudo nixos-rebuild switch --flake ~/nixos-config#bosgame";
      cleanup = "sudo nix-collect-garbage -d";
      gs = "git status";
      gp = "git push";
    };
    interactiveShellInit = ''
      set -g fish_greeting  # Disable greeting
    '';
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
      font_family = "JetBrains Mono";
      font_size = 12;
      background_opacity = "0.95";
      window_padding_width = 8;
      confirm_os_window_close = 0;
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

  # === GPG ===
  programs.gpg.enable = true;
  services.gpg-agent = {
    enable = true;
    pinentryPackage = pkgs.pinentry-gnome3;
    enableSshSupport = true;
  };
}
