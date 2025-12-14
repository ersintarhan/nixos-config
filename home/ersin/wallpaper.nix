{ pkgs, ... }:

{
  home.packages = with pkgs; [
    swww
    wget
  ];

  # Make swww-daemon a systemd service for reliability
  systemd.user.services.swww-daemon = {
    Unit = {
      Description = "SWWW Wallpaper Daemon";
      PartOf = [ "graphical-session.target" ];
    };
    Service = {
      ExecStart = "${pkgs.swww}/bin/swww-daemon";
      Restart = "on-failure";
      RestartSec = "1";
    };
    Install = {
      WantedBy = [ "graphical-session.target" ];
    };
  };

  # Updated wallpaper script
  home.file.".local/bin/random-wallpaper".text = ''
    #!/bin/sh
    # Set a cache directory
    WALLPAPER_DIR="$HOME/.cache/wallpapers"
    mkdir -p "$WALLPAPER_DIR"

    # Fetch a new random wallpaper. The URL is simplified to improve reliability.
    # You can add more keywords separated by commas, e.g., ?nature,water,fire
    WALLPAPER_PATH="$WALLPAPER_DIR/wallpaper-$(date +%s).jpg"
    if ! wget "https://source.unsplash.com/random/1920x1080/?nature" -O "$WALLPAPER_PATH"; then
        echo "Failed to download wallpaper from Unsplash. Exiting."
        exit 1
    fi

    # Wait for the swww-daemon to be ready (up to 5 seconds)
    for i in $(seq 1 5); do
      if swww query > /dev/null 2>&1; then
        break
      fi
      echo "Waiting for swww-daemon..."
      sleep 1
    done

    # Set the wallpaper using swww
    swww img "$WALLPAPER_PATH" --transition-type any --transition-pos bottom-right

    # Keep the latest 10 wallpapers to save space
    find "$WALLPAPER_DIR" -type f -name "wallpaper-*.jpg" | sort -r | tail -n +11 | xargs -r rm
  '';
  home.file.".local/bin/random-wallpaper".executable = true;

  # systemd service and timer for the script
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