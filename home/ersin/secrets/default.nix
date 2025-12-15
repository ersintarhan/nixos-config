# Secrets Management (SOPS)
{ config, pkgs, lib, ... }:

{
  imports = [
    ./sops.nix
  ];
}
