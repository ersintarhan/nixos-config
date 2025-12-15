# Core Shell & CLI Tools
{ config, pkgs, lib, ... }:

{
  imports = [
    ./fish.nix
    ./bash.nix
    ./starship.nix
    ./git.nix
    ./ssh.nix
    ./eza.nix
    ./vivid.nix
    ./k9s.nix
  ];

  # === Environment Variables ===
  home.sessionVariables = {
    CONSUL_HTTP_ADDR = "http://10.101.1.11:8500";
    NOMAD_ADDR = "http://10.101.1.21:4646";
    TERMINAL = "foot";
    EDITOR = "micro";
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
  programs.fastfetch.enable = true;

  # === Direnv (auto-load dev environments) ===
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  # === Other CLI Tools ===
  programs.pgcli.enable = true;

  # === GPG ===
  programs.gpg.enable = true;
  services.gpg-agent = {
    enable = true;
    pinentry.package = pkgs.pinentry-gnome3;
    enableSshSupport = true;
  };

  # === SSH Public Keys ===
  home.file.".ssh/id_ed25519.pub".text =
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGXlNY23o4h8SeXTVhK8reQSSbblhmka3MjOZrwtTyvx";
  home.file.".ssh/id_rsa.pub".text =
    "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCvcwwoUSFyFi56PUlbGwY57JnzBSKpVgTKkZcT8LQnwLIy6oNObVU/vBcJFG9haVZI/KimKRopPoPltohc54fq0mZOtAfZseF4CbPHXAXIoZokceUkPbYEBxfEeGhmdaoq1LsbweSgdEfiweQScMQkkPNPbYZ3eL2DetI51vrAla5aBSr3yDOhVYUU9GjwVhKHIR0XQmuhWqiUVH08gpDiLzfS3MK62R3TzzuKyQ0IwLCBAuJqHthwpixqtq0hS506PrCH1WlhkzjYFL4HQM4etkqBzgkXyVubIZy0KQKfDBmWWeCe1yz81KBGSG8HT85hQO6yQpTUwBkCNFAqvBUy8/BPjY7hzNQhkRYFWIz/ztGAclJ1+q+kIBTPoXjXG6aYMiTGKkIIEQyQLYuKdBb+Y9THf4LWxOwqI/21RWNyLMxh4ERuUN3NnOhDe/DX9YZQ/5rxRT4vorBIlxDz/jjWYmadmOF/IFF+SNcjH5JqJYdJ4YXlhhy6HX0rvwMhLp0=";
}
