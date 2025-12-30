# SSH Configuration

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
      "ssh.dev.azure.com" = {
        hostname = "ssh.dev.azure.com";
        user = "git";
        identityFile = "~/.ssh/azure_devops_rsa";
        identitiesOnly = true;
      };
      "vs-ssh.visualstudio.com" = {
        hostname = "vs-ssh.visualstudio.com";
        user = "git";
        identityFile = "~/.ssh/azure_devops_rsa";
        identitiesOnly = true;
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
}
