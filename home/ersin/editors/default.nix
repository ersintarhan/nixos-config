# Text Editors
{ config, pkgs, lib, ... }:

{
  imports = [
    ./micro.nix
    ./zed.nix
  ];
}
