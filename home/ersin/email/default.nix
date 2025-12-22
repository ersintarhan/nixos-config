# Email Configuration (Thunderbird + GPG)
{ config, pkgs, lib, ... }:

{
  imports = [
    ./gpg.nix
  ];

  # === Thunderbird Profile ===
  # Note: Thunderbird is installed via system packages
  # This configures user-level settings

  # Thunderbird user.js preferences (optional customization)
  home.file.".thunderbird/profiles.ini".text = ''
    [Profile0]
    Name=default
    IsRelative=1
    Path=default
    Default=1

    [General]
    StartWithLastProfile=1
    Version=2
  '';

  # Create default profile directory
  home.file.".thunderbird/default/.keep".text = "";

  # Thunderbird user preferences
  home.file.".thunderbird/default/user.js".text = ''
    // Privacy & Security
    user_pref("mail.default_send_format", 1); // Plain text default
    user_pref("mailnews.start_page.enabled", false);
    user_pref("mailnews.message_display.disable_remote_image", true);

    // GPG/OpenPGP
    user_pref("mail.openpgp.enable", true);
    user_pref("mail.e2ee.auto_enable", true);
    user_pref("mail.e2ee.auto_disable", false);

    // Compose
    user_pref("mail.identity.default.compose_html", false);
    user_pref("mail.SpellCheckBeforeSend", true);

    // UI
    user_pref("mail.tabs.drawInTitlebar", true);
    user_pref("mail.uidensity", 1); // Compact view

    // Performance
    user_pref("mail.server.default.check_all_folders_for_new", true);
    user_pref("mail.server.default.autosync_offline_stores", true);
  '';
}
