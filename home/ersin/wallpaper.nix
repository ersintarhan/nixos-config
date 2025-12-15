{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    swww
    # curl is used by the python script implicitly via urllib
    # jq is no longer needed as Python handles JSON parsing
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

  # Use the external Python script as the wallpaper command
  home.file.".local/bin/random-wallpaper" = {
    source = ./programs/scripts/random-wallpaper.py;
    executable = true;
  };

  # systemd service and timer for the script
  systemd.user.services.random-wallpaper = {
    Unit = {
      Description = "Set a random wallpaper from Wallhaven";
    };
    Service = {
      Type = "oneshot";
      # Execute the Python script, passing the API key file path as an argument.
      # The script's shebang will ensure it's run with the correct Python interpreter.
      ExecStart = ''
        ${config.home.homeDirectory}/.local/bin/random-wallpaper \
        ${config.sops.secrets.wallhaven_api_key.path}
      '';
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
