# SSH Configuration
{ config, pkgs, ... }:

{
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
        identityFile = "~/.ssh/id_rsa";
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

  # This is related to SSH but is a file definition,
  # it's better to keep it with other file definitions in programs.nix
  # or move it to a dedicated secrets/files management module.
  # For now, it will be moved back to programs.nix to keep this file clean.
}
