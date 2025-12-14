# Secrets Management with sops-nix
{ config, ... }:

{
  sops = {
    # GPG key for decryption
    gnupg.home = "${config.home.homeDirectory}/.gnupg";
    gnupg.sshKeyPaths = []; # GPG kullanıyoruz, SSH değil

    # Default secrets file
    defaultSopsFile = ../../secrets/secrets.yaml;

    secrets = {
      # Kubeconfig - decrypts to ~/.kube/config
      kubeconfig = {
        path = "${config.home.homeDirectory}/.kube/config";
        mode = "0600";
      };

      # Örnek: API token
      # api_token = {
      #   path = "${config.home.homeDirectory}/.config/some-app/token";
      # };
    };
  };

  # Ensure .kube directory exists
  home.file.".kube/.keep".text = "";
}
