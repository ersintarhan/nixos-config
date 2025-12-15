# Secrets Management with sops-nix
{ config, ... }:

{
  sops = {
    # GPG key for decryption
    gnupg.home = "${config.home.homeDirectory}/.gnupg";
    gnupg.sshKeyPaths = [ ]; # GPG kullanıyoruz, SSH değil

    # Default secrets file
    defaultSopsFile = ../../secrets/secrets.yaml;

    secrets = {
      # Kubeconfig - decrypts to ~/.kube/config
      kubeconfig = {
        path = "${config.home.homeDirectory}/.kube/config";
        mode = "0600";
      };

      # SSH Keys
      ssh_id_ed25519 = {
        path = "${config.home.homeDirectory}/.ssh/id_ed25519";
        mode = "0600";
      };

      ssh_id_rsa = {
        path = "${config.home.homeDirectory}/.ssh/id_rsa";
        mode = "0600";
      };

      # Wallhaven API Key
      wallhaven-api-key = {
        path = "${config.home.homeDirectory}/.config/wallhaven-api-key";
        mode = "0000"; # Read-only, minimal permissions
      };
    };
  };

  # Ensure directories exist
  home.file.".kube/.keep".text = "";
  home.file.".ssh/.keep".text = "";
}
