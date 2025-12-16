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
      # .NET files (Rider)
      "application/x-dotnet-sln" = "rider.desktop";
      "application/x-dotnet-csproj" = "rider.desktop";
      "application/x-dotnet-fsproj" = "rider.desktop";
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

  # === JetBrains Rider (stable desktop file) ===
  home.file.".local/share/applications/rider.desktop".text = ''
    [Desktop Entry]
    Name=Rider
    Exec=${config.home.homeDirectory}/.local/share/JetBrains/Toolbox/apps/rider/bin/rider %f
    Version=1.0
    Type=Application
    Categories=Development;IDE;
    Terminal=false
    Icon=rider
    Comment=JetBrains Rider - .NET IDE
    StartupWMClass=jetbrains-rider
    StartupNotify=true
    MimeType=application/x-dotnet-sln;application/x-dotnet-csproj;
  '';

  # === Custom MIME types for .NET files ===
  home.file.".local/share/mime/packages/dotnet.xml".text = ''
    <?xml version="1.0" encoding="UTF-8"?>
    <mime-info xmlns="http://www.freedesktop.org/standards/shared-mime-info">
      <mime-type type="application/x-dotnet-sln">
        <comment>Visual Studio Solution</comment>
        <glob pattern="*.sln"/>
        <icon name="rider"/>
      </mime-type>
      <mime-type type="application/x-dotnet-csproj">
        <comment>C# Project File</comment>
        <glob pattern="*.csproj"/>
        <icon name="rider"/>
      </mime-type>
      <mime-type type="application/x-dotnet-fsproj">
        <comment>F# Project File</comment>
        <glob pattern="*.fsproj"/>
        <icon name="rider"/>
      </mime-type>
    </mime-info>
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

  # === Update MIME database on activation ===
  home.activation.updateMimeDatabase = lib.hm.dag.entryAfter ["writeBoundary"] ''
    ${pkgs.shared-mime-info}/bin/update-mime-database ~/.local/share/mime
  '';

  home.stateVersion = "25.11";
}
