# GPG Configuration
{ config, pkgs, ... }:

{
  # === GPG Agent ===
  programs.gpg = {
    enable = true;
    settings = {
      # Use AES256, AES192, AES128, CAST5, 3DES
      personal-cipher-preferences = "AES256 AES192 AES";
      personal-digest-preferences = "SHA512 SHA384 SHA256";
      personal-compress-preferences = "ZLIB BZIP2 ZIP Uncompressed";

      # Default key preferences
      default-preference-list = "SHA512 SHA384 SHA256 AES256 AES192 AES ZLIB BZIP2 ZIP Uncompressed";

      # Use SHA512 when signing a key
      cert-digest-algo = "SHA512";
      s2k-digest-algo = "SHA512";
      s2k-cipher-algo = "AES256";

      # Avoid leaking information
      no-emit-version = true;
      no-comments = true;
      export-options = "export-minimal";

      # Display options
      keyid-format = "0xlong";
      with-fingerprint = true;

      # Trust model
      trust-model = "tofu+pgp";

      # Auto-fetch keys
      auto-key-locate = "local,wkd,keyserver";
      auto-key-retrieve = true;

      # Keyserver
      keyserver = "hkps://keys.openpgp.org";
    };
  };

  # === GPG Agent ===
  services.gpg-agent = {
    enable = true;

    # Cache TTL (in seconds)
    defaultCacheTtl = 3600; # 1 hour
    maxCacheTtl = 86400; # 24 hours

    # SSH support (optional - use GPG key for SSH)
    enableSshSupport = false;

    # Pinentry program (GNOME3 for GUI)
    pinentryPackage = pkgs.pinentry-gnome3;

    # Extra config
    extraConfig = ''
      allow-loopback-pinentry
    '';
  };

  # === Environment for GPG ===
  home.sessionVariables = {
    # Tell GPG to use the agent
    GPG_TTY = "$(tty)";
  };

  # Ensure gnome-keyring doesn't interfere
  home.file.".gnupg/gpg-agent.conf".text = ''
    # Use GNOME pinentry
    pinentry-program ${pkgs.pinentry-gnome3}/bin/pinentry-gnome3

    # Cache settings
    default-cache-ttl 3600
    max-cache-ttl 86400

    # Allow loopback for GUI apps
    allow-loopback-pinentry
  '';
}
