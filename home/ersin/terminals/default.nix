# Terminal Emulators
{ config, pkgs, lib, ... }:

{
  imports = [
    ./kitty.nix
    ./foot.nix
    ./alacritty.nix
  ];
}
