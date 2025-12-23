# Python Development Module
# Modern Python development with uv
{ config, pkgs, lib, ... }:

{
  environment.systemPackages = with pkgs; [
    python313       # Latest Python
    uv              # Fast package manager & venv
  ];

  # UV environment variables
  environment.sessionVariables = {
    UV_SYSTEM_PYTHON = "1";  # Use system Python by default
  };
}
