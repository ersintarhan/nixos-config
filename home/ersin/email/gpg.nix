# GPG Extended Settings for Email
# Base GPG config is in core/default.nix
# This file adds email-specific GPG settings
{ config, pkgs, lib, ... }:

{
  # === Extended GPG Settings ===
  programs.gpg.settings = {
    # Use AES256, AES192, AES128
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

  # === GPG Agent Extra Config ===
  # Note: Base gpg-agent config is in core/default.nix
  services.gpg-agent = {
    # Cache TTL (in seconds)
    defaultCacheTtl = 3600; # 1 hour
    maxCacheTtl = 86400; # 24 hours

    # Extra config
    extraConfig = ''
      allow-loopback-pinentry
    '';
  };
}
