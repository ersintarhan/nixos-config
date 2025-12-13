# Waybar Configuration (Home Manager)
{ config, pkgs, ... }:

{
  programs.waybar = {
    enable = true;

    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        height = 34;
        spacing = 4;
        modules-left = [ "niri/workspaces" "niri/window" ];
        modules-center = [ "clock" ];
        modules-right = [ "tray" "pulseaudio" "network" "bluetooth" "battery" "custom/power" ];

        "niri/workspaces" = {
          format = "{icon}";
          format-icons = {
            active = "";
            default = "";
          };
        };

        "niri/window" = {
          max-length = 50;
        };

        clock = {
          format = " {:%H:%M}";
          format-alt = " {:%A, %d %B %Y}";
          tooltip-format = "<tt><small>{calendar}</small></tt>";
        };

        tray = {
          icon-size = 18;
          spacing = 10;
        };

        pulseaudio = {
          format = "{icon} {volume}%";
          format-bluetooth = "{icon} {volume}%";
          format-muted = " muted";
          format-icons = {
            headphone = "";
            default = [ "" "" "" ];
          };
          on-click = "pavucontrol";
          on-click-right = "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
        };

        network = {
          format-wifi = " {signalStrength}%";
          format-ethernet = " {ipaddr}";
          format-disconnected = "⚠ Disconnected";
          tooltip-format = "{ifname}: {ipaddr}/{cidr}\n{essid}";
          on-click = "nm-connection-editor";
        };

        bluetooth = {
          format = " {status}";
          format-connected = " {device_alias}";
          format-connected-battery = " {device_alias} {device_battery_percentage}%";
          on-click = "blueman-manager";
        };

        battery = {
          states = {
            warning = 30;
            critical = 15;
          };
          format = "{icon} {capacity}%";
          format-charging = " {capacity}%";
          format-plugged = " {capacity}%";
          format-icons = [ "" "" "" "" "" ];
        };

        "custom/power" = {
          format = "⏻";
          tooltip = false;
          on-click = "wlogout";
        };
      };
    };

    style = ''
      * {
          font-family: "JetBrains Mono", "Font Awesome 6 Free";
          font-size: 13px;
          min-height: 0;
      }

      window#waybar {
          background: rgba(30, 30, 46, 0.9);
          color: #cdd6f4;
          border-bottom: 2px solid rgba(137, 180, 250, 0.5);
      }

      #workspaces button {
          padding: 0 8px;
          color: #6c7086;
          background: transparent;
          border: none;
          border-radius: 0;
      }

      #workspaces button.active {
          color: #89b4fa;
          background: rgba(137, 180, 250, 0.2);
      }

      #workspaces button:hover {
          background: rgba(137, 180, 250, 0.1);
      }

      #window {
          padding: 0 10px;
          color: #a6adc8;
      }

      #clock {
          padding: 0 12px;
          color: #f5c2e7;
          font-weight: bold;
      }

      #tray {
          padding: 0 8px;
      }

      #pulseaudio {
          padding: 0 10px;
          color: #fab387;
      }

      #pulseaudio.muted {
          color: #6c7086;
      }

      #network {
          padding: 0 10px;
          color: #94e2d5;
      }

      #network.disconnected {
          color: #f38ba8;
      }

      #bluetooth {
          padding: 0 10px;
          color: #89b4fa;
      }

      #bluetooth.disabled {
          color: #6c7086;
      }

      #battery {
          padding: 0 10px;
          color: #a6e3a1;
      }

      #battery.charging {
          color: #a6e3a1;
      }

      #battery.warning:not(.charging) {
          color: #fab387;
      }

      #battery.critical:not(.charging) {
          color: #f38ba8;
          animation: blink 0.5s linear infinite alternate;
      }

      @keyframes blink {
          to {
              color: #ffffff;
          }
      }

      #custom-power {
          padding: 0 12px;
          color: #f38ba8;
      }

      tooltip {
          background: rgba(30, 30, 46, 0.95);
          border: 1px solid #89b4fa;
          border-radius: 8px;
      }

      tooltip label {
          color: #cdd6f4;
      }
    '';
  };
}
