# .NET Development Module
# Enables .NET SDK and global tools support on NixOS
{ config, pkgs, lib, ... }:

let
  dotnetCombined = with pkgs.dotnetCorePackages; combinePackages [
    sdk_10_0
    sdk_9_0  # Many tools still target net9.0
    sdk_8_0  # LTS - some tools still use net8.0
  ];
in
{
  # .NET SDKs - combined for tool compatibility
  environment.systemPackages = [ dotnetCombined ];

  # Environment variables for .NET
  environment.sessionVariables = {
    DOTNET_ROOT = "${dotnetCombined}/share/dotnet";  # Must point to share/dotnet!
    DOTNET_CLI_TELEMETRY_OPTOUT = "1";
  };

  # Add ~/.dotnet/tools to PATH (for global tools)
  environment.shellInit = ''
    export PATH="$HOME/.dotnet/tools:$PATH"
  '';
}
