# Home Manager Configuration for Ersin
{ config, pkgs, lib, hostname ? "bosgame", ... }:

{
  imports = [
    # Modular imports
    ./core              # Shell, CLI tools, git, ssh
    ./desktop           # Niri, waybar, mako, rofi, gtk/qt
    ./terminals         # Kitty, foot, alacritty
    ./editors           # Micro, zed
    ./browsers          # Firefox
    ./theme             # Catppuccin
    ./containers        # Distrobox
    ./secrets           # SOPS

    # Host-specific configuration
    ./hosts/${hostname}.nix
  ];

  home.username = "ersin";
  home.homeDirectory = "/home/ersin";

  # Let Home Manager manage itself
  programs.home-manager.enable = true;

  # === Dark mode for apps ===
  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
    };
  };

  # === XDG Configuration ===
  xdg.enable = true;

  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      # Browser (Brave)
      "text/html" = "brave-browser.desktop";
      "x-scheme-handler/http" = "brave-browser.desktop";
      "x-scheme-handler/https" = "brave-browser.desktop";
      "x-scheme-handler/about" = "brave-browser.desktop";
      "x-scheme-handler/unknown" = "brave-browser.desktop";
      "application/xhtml+xml" = "brave-browser.desktop";
      "application/x-extension-htm" = "brave-browser.desktop";
      "application/x-extension-html" = "brave-browser.desktop";
      "application/x-extension-shtml" = "brave-browser.desktop";
      "application/x-extension-xhtml" = "brave-browser.desktop";
      "application/x-extension-xht" = "brave-browser.desktop";
      # File manager (Nemo)
      "inode/directory" = "nemo.desktop";
    };
  };

  xdg.userDirs = {
    enable = true;
    createDirectories = true;
    desktop = "${config.home.homeDirectory}/Desktop";
    documents = "${config.home.homeDirectory}/Documents";
    download = "${config.home.homeDirectory}/Downloads";
    music = "${config.home.homeDirectory}/Music";
    pictures = "${config.home.homeDirectory}/Pictures";
    videos = "${config.home.homeDirectory}/Videos";
  };

  # === Nemo File Manager Actions ===
  home.file.".local/share/nemo/actions/copy-full-path.nemo_action".text = ''
    [Nemo Action]
    Name=Copy Full Path
    Comment=Copy the full path to clipboard
    Exec=sh -c 'echo -n "%F" | wl-copy'
    Icon-Name=edit-copy
    Selection=any
    Extensions=any;
  '';

  home.file.".local/share/nemo/actions/copy-directory-path.nemo_action".text = ''
    [Nemo Action]
    Name=Copy Directory Path
    Comment=Copy the directory path to clipboard
    Exec=sh -c 'dirname "%F" | tr -d "\n" | wl-copy'
    Icon-Name=folder
    Selection=any
    Extensions=any;
  '';

  home.file.".local/share/nemo/actions/open-in-zed.nemo_action".text = ''
    [Nemo Action]
    Name=Open in Zed
    Comment=Open file or folder in Zed editor
    Exec=zeditor "%F"
    Icon-Name=zed
    Selection=any
    Extensions=any;
  '';

  home.file.".local/share/nemo/actions/open-in-antigravity.nemo_action".text = ''
    [Nemo Action]
    Name=Open in Antigravity
    Comment=Open file or folder in Antigravity AI IDE
    Exec=antigravity "%F"
    Icon-Name=antigravity
    Selection=any
    Extensions=any;
  '';

  home.file.".local/share/nemo/actions/open-in-kitty.nemo_action".text = ''
    [Nemo Action]
    Name=Open Terminal Here
    Comment=Open Kitty terminal in this directory
    Exec=kitty --working-directory="%P"
    Icon-Name=utilities-terminal
    Selection=any
    Extensions=dir;
  '';

  # Disable tray applets (using waybar modules instead)
  home.file.".config/autostart/blueman.desktop".text = ''
    [Desktop Entry]
    Hidden=true
  '';

  home.file.".config/autostart/nm-applet.desktop".text = ''
    [Desktop Entry]
    Hidden=true
  '';

  home.stateVersion = "25.11";
}
