# Home Manager Configuration for Ersin
{ config, pkgs, ... }:

{
  imports = [
    # Main modules
    ./programs.nix
    ./niri.nix
    ./waybar.nix
    ./mako.nix
    ./secrets.nix
    ./distrobox.nix
    ./wallpaper.nix
    ./catppuccin.nix

    # Modularized program configurations
    ./programs/fish.nix
    ./programs/kitty.nix
    ./programs/foot.nix
    ./programs/starship.nix
    ./programs/ssh.nix
    ./programs/git.nix
    ./programs/zed.nix
    ./programs/bash.nix
    ./programs/alacritty.nix
    ./programs/fuzzel.nix
    ./programs/k9s.nix
    ./programs/vivid.nix
    ./programs/firefox.nix
    ./programs/micro.nix
    ./programs/eza.nix
  ];

  home.username = "ersin";
  home.homeDirectory = "/home/ersin";

  # Let Home Manager manage itself
  programs.home-manager.enable = true;

  # User packages (GUI apps etc.)
  home.packages = with pkgs; [
    # Add user-specific packages here
  ];

  # === GTK Theme (catppuccin manages icons) ===
  gtk = {
    enable = true;
    theme = {
      name = "Adwaita-dark";
      package = pkgs.gnome-themes-extra;
    };
    cursorTheme = {
      name = "Adwaita";
      package = pkgs.adwaita-icon-theme;
      size = 24;
    };
    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = true;
    };
    gtk4.extraConfig = {
      gtk-application-prefer-dark-theme = true;
    };
  };

  # === Qt Theme ===
  qt = {
    enable = true;
    platformTheme.name = "kvantum";
    style.name = "kvantum";
  };

  # === Dark mode for apps ===
  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
    };
  };

  # XDG directories
  xdg.enable = true;

  # Default applications (Edge as default browser)
  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      # Browser
      "text/html" = "microsoft-edge.desktop";
      "x-scheme-handler/http" = "microsoft-edge.desktop";
      "x-scheme-handler/https" = "microsoft-edge.desktop";
      "x-scheme-handler/about" = "microsoft-edge.desktop";
      "x-scheme-handler/unknown" = "microsoft-edge.desktop";
      "application/xhtml+xml" = "microsoft-edge.desktop";
      "application/x-extension-htm" = "microsoft-edge.desktop";
      "application/x-extension-html" = "microsoft-edge.desktop";
      "application/x-extension-shtml" = "microsoft-edge.desktop";
      "application/x-extension-xhtml" = "microsoft-edge.desktop";
      "application/x-extension-xht" = "microsoft-edge.desktop";
      # File manager
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

  # === Nemo Actions ===
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
