# .NET Development Module
# Enables .NET SDK and global tools support on NixOS
{ config, pkgs, lib, ... }:

{
  # .NET SDK
  environment.systemPackages = with pkgs; [
    dotnetCorePackages.sdk_10_0
  ];

  # Environment variables for .NET
  environment.sessionVariables = {
    DOTNET_ROOT = "${pkgs.dotnetCorePackages.sdk_10_0}";
    DOTNET_CLI_TELEMETRY_OPTOUT = "1";
  };

  # Add ~/.dotnet/tools to PATH (for global tools)
  environment.shellInit = ''
    export PATH="$HOME/.dotnet/tools:$PATH"
  '';
}
