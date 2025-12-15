# Host-specific configuration for bosgame
# This machine has ROCm-capable GPU for AI workloads
{ config, pkgs, lib, ... }:

{
  home.packages = with pkgs; [
    # ROCm tools (AMD GPU compute)
    rocmPackages.rocminfo
    rocmPackages.rocm-smi
    clinfo
  ];
}
