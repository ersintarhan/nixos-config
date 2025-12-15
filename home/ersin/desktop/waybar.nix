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
        spacing = 0;
        reload_style_on_change = true;

        modules-left = [
          "custom/logo"
          "custom/sep"
          "niri/workspaces"
          "custom/sep"
          "wlr/taskbar"
        ];

        modules-center = [
          "custom/left-arrow"
          "custom/cpuinfo"
          "custom/sep-center"
          "memory"
          "custom/sep-center"
          "cpu"
          "custom/right-arrow"
          "custom/left-arrow2"
          "clock"
          "custom/right-arrow2"
        ];

        modules-right = [
          "keyboard-state"
          "custom/todo"
          "custom/sep"
          "tray"
          "custom/sep"
          "pulseaudio"
          "backlight"
          "network"
          "bluetooth"
          "battery"
          "custom/sep"
          "custom/power"
        ];

        # === Left Modules ===
        "custom/logo" = {
          format = "  ";
          tooltip = false;
        };

        "niri/workspaces" = {
          format = "{index}";
          on-scroll-up = "niri msg action focus-workspace-up";
          on-scroll-down = "niri msg action focus-workspace-down";
        };

        "wlr/taskbar" = {
          format = "{icon}";
          icon-size = 18;
          tooltip-format = "{title}";
          on-click = "activate";
          on-click-middle = "close";
          on-click-right = "minimize-raise";
        };

        # === Center Modules ===
        "custom/cpuinfo" = {
          exec = "~/.config/waybar/scripts/cpu-temp.sh";
          return-type = "json";
          format = "{}";
          tooltip = true;
          interval = 5;
        };

        memory = {
          format = "󰘚 {percentage}%";
          tooltip = true;
          tooltip-format = "RAM: {used:0.1f}GB / {total:0.1f}GB";
          interval = 5;
        };

        cpu = {
          format = " {usage}%";
          tooltip = true;
          interval = 5;
        };

        clock = {
          format = " {:%H:%M}";
          format-alt = " {:%A, %d %B %Y}";
          tooltip-format = "<tt><small>{calendar}</small></tt>";
          calendar = {
            mode = "month";
            format = {
              months = "<span color='#f5c2e7'><b>{}</b></span>";
              weekdays = "<span color='#94e2d5'><b>{}</b></span>";
              today = "<span color='#f38ba8'><b>{}</b></span>";
            };
          };
        };

        # === Right Modules ===
        "keyboard-state" = {
          capslock = true;
          format = "{icon}";
          format-icons = {
            locked = " CAPS";
            unlocked = "";
          };
        };

        "custom/todo" = {
          format = " {}";
          exec = "~/.config/waybar/scripts/todo.sh";
          return-type = "json";
          interval = 10;
          on-click = "~/.config/waybar/scripts/todo.sh toggle";
          on-click-right = "kitty -e ~/.config/waybar/scripts/todo.sh edit";
          tooltip = true;
        };

        tray = {
          icon-size = 18;
          spacing = 10;
        };

        pulseaudio = {
          format = "{icon} {volume}%";
          format-bluetooth = "󰂯 {volume}%";
          format-muted = "󰝟 ";
          format-icons = {
            headphone = "󰋋";
            default = [ "󰕿" "󰖀" "󰕾" ];
          };
          tooltip-format = "{desc}";
          on-click = "pavucontrol";
          on-click-right = "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
          on-scroll-up = "wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+";
          on-scroll-down = "wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-";
        };

        backlight = {
          format = "{icon} {percent}%";
          format-icons = [ "󰃞" "󰃟" "󰃠" ];
          tooltip = false;
          on-scroll-up = "brightnessctl s +5%";
          on-scroll-down = "brightnessctl s 5%-";
        };

        network = {
          format-wifi = "󰤨 {signalStrength}%";
          format-ethernet = "󰈀 ";
          format-disconnected = "󰤭 ";
          tooltip-format-wifi = "{essid} ({signalStrength}%)\n{ipaddr}/{cidr}";
          tooltip-format-ethernet = "{ifname}\n{ipaddr}/{cidr}";
          on-click = "nm-connection-editor";
        };

        bluetooth = {
          format = "󰂯";
          format-disabled = "󰂲";
          format-connected = "󰂱 {num_connections}";
          tooltip-format = "{controller_alias}\n{status}";
          tooltip-format-connected = "{device_enumerate}";
          tooltip-format-enumerate-connected = "{device_alias}";
          on-click = "blueman-manager";
        };

        battery = {
          states = {
            full = 100;
            good = 80;
            warning = 30;
            critical = 15;
          };
          format = "{icon} {capacity}%";
          format-charging = "󱘖 {capacity}%";
          format-plugged = "󰚥 {capacity}%";
          format-icons = [ "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" ];
          tooltip-format = "{timeTo}";
        };

        "custom/power" = {
          format = "⏻ ";
          tooltip = true;
          tooltip-format = "Power Menu";
          on-click = "wlogout";
        };

        # === Separators & Arrows ===
        "custom/sep" = {
          format = "│";
          tooltip = false;
        };

        "custom/sep-center" = {
          format = "";
          tooltip = false;
        };

        "custom/left-arrow" = {
          format = "";
          tooltip = false;
        };

        "custom/right-arrow" = {
          format = "";
          tooltip = false;
        };

        "custom/left-arrow2" = {
          format = "";
          tooltip = false;
        };

        "custom/right-arrow2" = {
          format = "";
          tooltip = false;
        };
      };
    };

    style = ''
      /* Catppuccin Mocha Colors */
      @define-color base #1e1e2e;
      @define-color mantle #181825;
      @define-color crust #11111b;
      @define-color text #cdd6f4;
      @define-color subtext0 #a6adc8;
      @define-color subtext1 #bac2de;
      @define-color surface0 #313244;
      @define-color surface1 #45475a;
      @define-color overlay0 #6c7086;
      @define-color blue #89b4fa;
      @define-color lavender #b4befe;
      @define-color sapphire #74c7ec;
      @define-color sky #89dceb;
      @define-color teal #94e2d5;
      @define-color green #a6e3a1;
      @define-color yellow #f9e2af;
      @define-color peach #fab387;
      @define-color maroon #eba0ac;
      @define-color red #f38ba8;
      @define-color mauve #cba6f7;
      @define-color pink #f5c2e7;
      @define-color flamingo #f2cdcd;
      @define-color rosewater #f5e0dc;

      * {
        font-family: "JetBrainsMono Nerd Font", "Font Awesome 6 Free";
        font-size: 13px;
        min-height: 0;
        border: none;
        border-radius: 0;
      }

      window#waybar {
        background: alpha(@base, 0.95);
        color: @text;
      }

      tooltip {
        background: @base;
        border: 1px solid @blue;
        border-radius: 8px;
      }

      tooltip label {
        color: @text;
        padding: 4px;
      }

      /* Logo */
      #custom-logo {
        color: @blue;
        font-size: 16px;
        padding: 0 12px 0 8px;
      }

      /* Workspaces */
      #workspaces {
        padding: 0 4px;
      }

      #workspaces button {
        padding: 0 8px;
        color: @overlay0;
        background: transparent;
      }

      #workspaces button.active {
        color: @blue;
        background: alpha(@blue, 0.2);
      }

      #workspaces button:hover {
        background: alpha(@blue, 0.1);
        color: @lavender;
      }

      /* Taskbar */
      #taskbar {
        padding: 0 4px;
      }

      #taskbar button {
        padding: 0 6px;
        background: transparent;
        border-radius: 4px;
        margin: 2px;
      }

      #taskbar button:hover {
        background: alpha(@blue, 0.2);
      }

      #taskbar button.active {
        background: alpha(@mauve, 0.3);
      }

      /* Center section with arrows */
      #custom-left-arrow {
        color: @surface0;
        font-size: 16px;
      }

      #custom-right-arrow {
        color: @surface0;
        font-size: 16px;
      }

      #custom-left-arrow2 {
        color: @mauve;
        font-size: 16px;
        padding-left: 8px;
      }

      #custom-right-arrow2 {
        color: @mauve;
        font-size: 16px;
        padding-right: 8px;
      }

      #custom-cpuinfo {
        background: @surface0;
        color: @peach;
        padding: 0 10px;
      }

      #memory {
        background: @surface0;
        color: @green;
        padding: 0 10px;
      }

      #cpu {
        background: @surface0;
        color: @sky;
        padding: 0 10px;
      }

      #custom-sep-center {
        background: @surface0;
        color: @overlay0;
        padding: 0 4px;
      }

      #clock {
        background: @mauve;
        color: @crust;
        font-weight: bold;
        padding: 0 12px;
      }

      /* Right section */
      #keyboard-state {
        color: @yellow;
        padding: 0 8px;
      }

      #custom-todo {
        color: @green;
        padding: 0 8px;
      }

      #custom-sep {
        color: @surface1;
        padding: 0 4px;
      }

      #tray {
        padding: 0 8px;
      }

      #tray > .passive {
        -gtk-icon-effect: dim;
      }

      #tray > .needs-attention {
        -gtk-icon-effect: highlight;
      }

      #pulseaudio {
        color: @peach;
        padding: 0 8px;
      }

      #pulseaudio.muted {
        color: @overlay0;
      }

      #backlight {
        color: @yellow;
        padding: 0 8px;
      }

      #network {
        color: @teal;
        padding: 0 8px;
      }

      #network.disconnected {
        color: @red;
      }

      #bluetooth {
        color: @blue;
        padding: 0 8px;
      }

      #bluetooth.disabled {
        color: @overlay0;
      }

      #battery {
        color: @green;
        padding: 0 8px;
      }

      #battery.charging {
        color: @green;
      }

      #battery.warning:not(.charging) {
        color: @yellow;
      }

      #battery.critical:not(.charging) {
        color: @red;
        animation: blink 0.5s linear infinite alternate;
      }

      @keyframes blink {
        to { color: @text; }
      }

      #custom-power {
        color: @red;
        padding: 0 12px 0 8px;
      }

      #custom-power:hover {
        color: @maroon;
      }
    '';
  };

  # Waybar scripts
  home.file.".config/waybar/scripts/cpu-temp.sh" = {
    executable = true;
    text = ''
      #!/usr/bin/env bash

      # Get CPU temperature
      temp=$(sensors 2>/dev/null | grep -oP 'Package.*?\+\K[0-9.]+' | head -1)

      if [ -z "$temp" ]; then
        temp=$(sensors 2>/dev/null | grep -oP 'Tctl.*?\+\K[0-9.]+' | head -1)
      fi

      if [ -z "$temp" ]; then
        temp=$(cat /sys/class/thermal/thermal_zone0/temp 2>/dev/null)
        temp=$((temp / 1000))
      fi

      if [ -z "$temp" ]; then
        echo '{"text": "N/A", "tooltip": "Temperature unavailable"}'
        exit 0
      fi

      temp_int=''${temp%.*}

      if [ "$temp_int" -ge 80 ]; then
        icon="󰸁"
        class="critical"
      elif [ "$temp_int" -ge 60 ]; then
        icon="󰔏"
        class="warning"
      else
        icon="󰔏"
        class="normal"
      fi

      echo "{\"text\": \"$icon ''${temp_int}°C\", \"tooltip\": \"CPU Temperature: ''${temp}°C\", \"class\": \"$class\"}"
    '';
  };

  home.file.".config/waybar/scripts/todo.sh" = {
    executable = true;
    text = ''
      #!/usr/bin/env bash

      TODO_FILE="$HOME/.local/share/waybar-todo.txt"

      # Create file if not exists
      [ ! -f "$TODO_FILE" ] && touch "$TODO_FILE"

      case "$1" in
        toggle)
          # Show todo in fuzzel for quick view
          if [ -s "$TODO_FILE" ]; then
            cat "$TODO_FILE" | fuzzel --dmenu --prompt="Todo: "
          else
            echo "No todos" | fuzzel --dmenu --prompt="Todo: "
          fi
          ;;
        edit)
          # Open in micro editor
          micro "$TODO_FILE"
          ;;
        *)
          # Default: output for waybar
          count=$(wc -l < "$TODO_FILE" 2>/dev/null | tr -d ' ')
          [ "$count" = "" ] && count=0

          if [ "$count" -gt 0 ]; then
            first=$(head -1 "$TODO_FILE")
            tooltip=$(cat "$TODO_FILE" | sed 's/$/\\n/' | tr -d '\n' | sed 's/\\n$//')
            echo "{\"text\": \"$count\", \"tooltip\": \"$tooltip\", \"class\": \"has-todos\"}"
          else
            echo "{\"text\": \"0\", \"tooltip\": \"No todos - click to add\", \"class\": \"empty\"}"
          fi
          ;;
      esac
    '';
  };
}
