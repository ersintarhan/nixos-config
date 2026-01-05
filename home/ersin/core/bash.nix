# Bash Configuration
{ config, pkgs, ... }:

{
  programs.bash = {
    enable = true; # Ensure bash is enabled in Home Manager

    initExtra = ''
      # Add .NET Core SDK tools to PATH
      export PATH="$PATH:$HOME/.dotnet/tools"

      # Load Brave Search API key from sops secret
      if [ -f ~/.config/brave-search-api-key ]; then
        export BRAVE_API_KEY=$(cat ~/.config/brave-search-api-key)
      fi
    '';
  };
}
