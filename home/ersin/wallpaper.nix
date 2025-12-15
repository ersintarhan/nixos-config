{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    swww
    curl
    jq # Needed for JSON parsing from Wallhaven API
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

  # Updated wallpaper script for Wallhaven API
  home.file.".local/bin/random-wallpaper".text = ''
    #!/bin/sh
    # Set a cache directory
    WALLPAPER_DIR="$HOME/.cache/wallpapers"
    mkdir -p "$WALLPAPER_DIR"

    # API Key file path is passed as the first argument from systemd
    API_KEY_FILE="$1"
    if [ -z "$API_KEY_FILE" ]; then
      echo "Error: Wallhaven API key file path not provided to script." >&2
      exit 1
    fi
    API_KEY=$(cat "$API_KEY_FILE")
    if [ -z "$API_KEY" ]; then
      echo "Error: Wallhaven API key is empty." >&2
      exit 1
    fi

    # Wallhaven API parameters
    # Resolution: 2K (2560x1440)
    # Categories: General (100)
    # Purity: SFW (100)
    # Sorting: Random
    # Ratios: 16x9 (for standard monitors)
    API_URL="https://wallhaven.cc/api/v1/search?apikey=\${API_KEY}&q=nature&categories=100&purity=100&atleast=2560x1440&sorting=random&ratios=16x9"
    USER_AGENT="Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/115.0"
    
    # Fetch wallpaper list from Wallhaven API
    API_RESPONSE=$(curl -s -L -A "$USER_AGENT" "$API_URL")
    
    # Extract image URL using jq
    # Fallback to an empty string if data[0].path is null or not found
    IMAGE_URL=$(echo "$API_RESPONSE" | ${pkgs.jq}/bin/jq -r '.data[0].path // empty')

    if [ -z "$IMAGE_URL" ] || [ "$IMAGE_URL" = "null" ]; then
      echo "Failed to get a valid image URL from Wallhaven API." >&2
      echo "API Response: $API_RESPONSE" >&2
      exit 1
    fi

    # Download the actual wallpaper image
    WALLPAPER_PATH="$WALLPAPER_DIR/wallpaper-$(date +%s).jpg"
    if ! curl -L -A "$USER_AGENT" -o "$WALLPAPER_PATH" "$IMAGE_URL"; then
        echo "Failed to download wallpaper from $IMAGE_URL. Exiting." >&2
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
      Description = "Set a random wallpaper from Wallhaven";
    };
    Service = {
      Type = "oneshot";
      # Pass the API key file path as an argument to the script
      ExecStart = "${pkgs.bash}/bin/bash %h/.local/bin/random-wallpaper ${config.sops.secrets.wallhaven-api-key.path}";
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
