# Cloud Management & Development Module
{
  config,
  pkgs,
  lib,
  ...
}:

{
  environment.systemPackages = with pkgs; [
    hcloud # Hetzner Cloud CLI
    # === HashiCorp ===
    nomad
    consul
    vault # lazım olur
    # === Kubernetes ===
    kubectl
    freelens-bin # Kubernetes IDE
    k9s # Kubernetes CLI

    # === Docker ===
    ducker # Docker CLI

  ];
}
