{ pkgs, ... }:

{
  # 1. Add swww and wget to packages
  home.packages = with pkgs; [
    swww
    wget
  ];

  # 2. Create wallpaper script
  home.file.".local/bin/random-wallpaper".text = ''
    #!/bin/sh
    # Set a cache directory
    WALLPAPER_DIR="$HOME/.cache/wallpapers"
    mkdir -p "$WALLPAPER_DIR"

    # Fetch a new random wallpaper from Unsplash (1920x1080, nature)
    # The image is saved with a unique name to avoid caching issues by swww
    WALLPAPER_PATH="$WALLPAPER_DIR/wallpaper-$(date +%s).jpg"
    wget "https://source.unsplash.com/random/1920x1080/?nature,water,fire,animals,wild,forest,urban,technology" -O "$WALLPAPER_PATH"

    # Set the wallpaper using swww
    swww img "$WALLPAPER_PATH" --transition-type any --transition-pos bottom-right

    # Optional: Clean up old wallpapers to save space
    # Keep the latest 10 wallpapers
    find "$WALLPAPER_DIR" -type f -name "wallpaper-*.jpg" | sort -r | tail -n +11 | xargs -r rm
  '';
  # Make it executable
  home.file.".local/bin/random-wallpaper".executable = true;

  # 3. Create systemd service and timer
  systemd.user.services.random-wallpaper = {
    Unit = {
      Description = "Set a random wallpaper from Unsplash";
    };
    Service = {
      Type = "oneshot";
      ExecStart = "${pkgs.bash}/bin/bash %h/.local/bin/random-wallpaper";
    };
  };

  systemd.user.timers.random-wallpaper = {
    Unit = {
      Description = "Run random wallpaper script every 10 minutes";
    };
    Timer = {
      OnBootSec = "1min";
      OnUnitActiveSec = "10min";
    };
    Install = {
      WantedBy = [ "timers.target" ];
    };
  };
}
