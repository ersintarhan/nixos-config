# Bash Configuration
{ config, pkgs, ... }:

{
  programs.bash = {
    enable = true; # Ensure bash is enabled in Home Manager

    extraInit = ''
      # Add .NET Core SDK tools to PATH
      export PATH="$PATH:$HOME/.dotnet/tools"
    '';
  };
}
