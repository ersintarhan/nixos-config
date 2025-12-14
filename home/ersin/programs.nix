# User Programs Configuration
{
  config,
  pkgs,
  lib,
  ...
}:

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

  # === SSH Public Keys (File Definitions) ===
  # These are kept here as they are file content definitions, not program configurations.
  home.file.".ssh/id_ed25519.pub".text =
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGXlNY23o4h8SeXTVhK8reQSSbblhmka3MjOZrwtTyvx";
  home.file.".ssh/id_rsa.pub".text =
    "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCvcwwoUSFyFi56PUlbGwY57JnzBSKpVgTKkZcT8LQnwLIy6oNObVU/vBcJFG9haVZI/KimKRopPoPltohc54fq0mZOtAfZseF4CbPHXAXIoZokceUkPbYEBxfEeGhmdaoq1LsbweSgdEfiweQScMQkkPNPbYZ3eL2DetI51vrAla5aBSr3yDOhVYUU9GjwVhKHIR0XQmuhWqiUVH08gpDiLzfS3MK62R3TzzuKyQ0IwLCBAuJqHthwpixqtq0hS506PrCH1WlhkzjYFL4HQM4etkqBzgkXyVubIZy0KQKfDBmWWeCe1yz81KBGSG8HT85hQO6yQpTUwBkCNFAqvBUy8/BPjY7hzNQhkRYFWIz/ztGAclJ1+q+kIBTPoXjXG6aYMiTGKkIIEQyQLYuKdBb+Y9THf4LWxOwqI/21RWNyLMxh4ERuUN3NnOhDe/DX9YZQ/5rxRT4vorBIlxDz/jjWYmadmOF/IFF+SNcjH5JqJYdJ4YXlhhy6HX0rvwMhLp0=";

  # === Other Programs ===
  programs.pgcli.enable = true;

  # === GPG ===
  programs.gpg.enable = true;
  services.gpg-agent = {
    enable = true;
    pinentry.package = pkgs.pinentry-gnome3;
    enableSshSupport = true;
  };
}