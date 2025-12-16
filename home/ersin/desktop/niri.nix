# Niri Configuration (Home Manager)

{
  # Niri config file
  xdg.configFile."niri/config.kdl".text = ''
    // Niri configuration for NixOS
    // Managed by Home Manager

    // ────────────── Xwayland ──────────────
    spawn-at-startup "xwayland-satellite"

    // ────────────── Startup Applications ──────────────
    spawn-at-startup "waybar"
    spawn-at-startup "mako"
    spawn-at-startup "/run/current-system/sw/libexec/polkit-gnome-authentication-agent-1"
    // swww-daemon is now managed by a systemd service.
    // Set initial wallpaper on startup.
    spawn-at-startup "sh -c '$HOME/.local/bin/random-wallpaper'"
    // spawn-at-startup "nm-applet" "--indicator"  // Disabled - using waybar network module

    // ────────────── Input Configuration ──────────────
    input {
        keyboard {
            xkb {
                layout "us"
                options "compose:ralt"
            }
            numlock
            repeat-delay 400
            repeat-rate 35
        }

        touchpad {
            tap
            natural-scroll
            dwt
        }

        mouse {
            accel-profile "flat"
        }

        focus-follows-mouse max-scroll-amount="10%"
        workspace-auto-back-and-forth
    }

    // ────────────── Layout Settings ──────────────
    layout {
        gaps 8
        center-focused-column "never"

        preset-column-widths {
            proportion 0.33333
            proportion 0.5
            proportion 0.66667
            proportion 0.75
            proportion 1.0
        }

        focus-ring {
            width 2
            active-color "#89b4fa"
            inactive-color "#6c7086"
        }

        shadow {
            on
            softness 30
            spread 3
            offset x=0 y=5
            color "#0007"
        }
    }

    // ────────────── Window Rules ──────────────
    // PiP windows always floating
    window-rule {
        match app-id=r#"firefox$"# title="^Picture-in-Picture$"
        open-floating true
    }

    // Waybar applets as floating dialogs
    window-rule {
        match app-id="nm-connection-editor"
        open-floating true
    }
    window-rule {
        match app-id=r#"blueman-manager"#
        open-floating true
        default-column-width { fixed 530; }
        default-window-height { fixed 500; }
    }
    window-rule {
        match app-id=r#"pavucontrol"#
        open-floating true
        default-column-width { fixed 520; }
        default-window-height { fixed 700; }
    }
    window-rule {
        match app-id="xdg-desktop-portal-gtk"
        open-floating true
    }

    // All windows: no rounded corners
    window-rule {
        geometry-corner-radius 0
        clip-to-geometry true
    }

    prefer-no-csd
    screenshot-path "~/Pictures/Screenshots/%Y-%m-%d_%H-%M-%S.png"
    hotkey-overlay {
        skip-at-startup
    }

    // ────────────── Animations ──────────────
    animations {
        workspace-switch {
            spring damping-ratio=1.0 stiffness=1000 epsilon=0.0001
        }
        window-open {
            duration-ms 200
            curve "ease-out-quad"
        }
        window-close {
            duration-ms 200
            curve "ease-out-cubic"
        }
        horizontal-view-movement {
            spring damping-ratio=1.0 stiffness=900 epsilon=0.0001
        }
        window-movement {
            spring damping-ratio=1.0 stiffness=800 epsilon=0.0001
        }
        window-resize {
            spring damping-ratio=1.0 stiffness=1000 epsilon=0.0001
        }
    }

    // ────────────── Environment Variables ──────────────
    environment {
        DISPLAY ":1"
        ELECTRON_OZONE_PLATFORM_HINT "auto"
        QT_QPA_PLATFORM "wayland"
        QT_WAYLAND_DISABLE_WINDOWDECORATION "1"
        XDG_SESSION_TYPE "wayland"
        XDG_CURRENT_DESKTOP "niri"
        GTK_THEME "Adwaita:dark"
        XDG_DATA_DIRS "/home/ersin/.local/share:/run/current-system/sw/share:/var/lib/flatpak/exports/share"
    }

    // ────────────── Keybindings ──────────────
    binds {
        Mod+Shift+Slash { show-hotkey-overlay; }

        // ─── Applications ───
        Mod+Return hotkey-overlay-title="Terminal: Foot" { spawn "footclient"; }
        Mod+T hotkey-overlay-title="Terminal: Kitty" { spawn "kitty"; }
        Mod+Shift+T hotkey-overlay-title="Terminal: Alacritty" { spawn "alacritty"; }
        Mod+Space hotkey-overlay-title="App Launcher" { spawn "rofi" "-show" "drun"; }
        Mod+D hotkey-overlay-title="App Launcher" { spawn "rofi" "-show" "drun"; }
        Mod+B hotkey-overlay-title="Browser: Microsoft Edge" { spawn "microsoft-edge"; }
        Mod+E hotkey-overlay-title="File Manager: Nemo" { spawn "nemo"; }
        Mod+Y hotkey-overlay-title="File Manager: Yazi" { spawn "kitty" "-e" "yazi"; }
        Super+Alt+L hotkey-overlay-title="Lock Screen" { spawn "swaylock"; }

        // ─── Audio Controls ───
        XF86AudioRaiseVolume allow-when-locked=true { spawn "wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "0.1+" "-l" "1.0"; }
        XF86AudioLowerVolume allow-when-locked=true { spawn "wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "0.1-"; }
        XF86AudioMute allow-when-locked=true { spawn "wpctl" "set-mute" "@DEFAULT_AUDIO_SINK@" "toggle"; }
        XF86AudioMicMute allow-when-locked=true { spawn "wpctl" "set-mute" "@DEFAULT_AUDIO_SOURCE@" "toggle"; }
        XF86AudioPlay allow-when-locked=true { spawn "playerctl" "play-pause"; }
        XF86AudioPause allow-when-locked=true { spawn "playerctl" "play-pause"; }
        XF86AudioNext allow-when-locked=true { spawn "playerctl" "next"; }
        XF86AudioPrev allow-when-locked=true { spawn "playerctl" "previous"; }

        // ─── Brightness Controls ───
        XF86MonBrightnessUp allow-when-locked=true { spawn "brightnessctl" "set" "+10%"; }
        XF86MonBrightnessDown allow-when-locked=true { spawn "brightnessctl" "set" "10%-"; }

        // ─── Window Management ───
        Mod+Q { close-window; }

        Mod+Left { focus-column-left; }
        Mod+H { focus-column-left; }
        Mod+Right { focus-column-right; }
        Mod+L { focus-column-right; }
        Mod+Up { focus-window-up; }
        Mod+K { focus-window-up; }
        Mod+Down { focus-window-down; }
        Mod+J { focus-window-down; }

        Mod+Ctrl+Left { move-column-left; }
        Mod+Ctrl+H { move-column-left; }
        Mod+Ctrl+Right { move-column-right; }
        Mod+Ctrl+L { move-column-right; }
        Mod+Ctrl+Up { move-window-up; }
        Mod+Ctrl+K { move-window-up; }
        Mod+Ctrl+Down { move-window-down; }
        Mod+Ctrl+J { move-window-down; }

        Mod+Comma { consume-or-expel-window-left; }
        Mod+Period { consume-or-expel-window-right; }

        Mod+Home { focus-column-first; }
        Mod+End { focus-column-last; }
        Mod+Ctrl+Home { move-column-to-first; }
        Mod+Ctrl+End { move-column-to-last; }

        // ─── Monitor Focus ───
        Mod+Shift+Left { focus-monitor-left; }
        Mod+Shift+Right { focus-monitor-right; }
        Mod+Shift+Up { focus-monitor-up; }
        Mod+Shift+Down { focus-monitor-down; }

        Mod+Shift+Ctrl+Left { move-column-to-monitor-left; }
        Mod+Shift+Ctrl+Right { move-column-to-monitor-right; }
        Mod+Shift+Ctrl+Up { move-column-to-monitor-up; }
        Mod+Shift+Ctrl+Down { move-column-to-monitor-down; }

        // ─── Workspaces ───
        Mod+WheelScrollDown cooldown-ms=150 { focus-workspace-down; }
        Mod+WheelScrollUp cooldown-ms=150 { focus-workspace-up; }
        Mod+Ctrl+WheelScrollDown cooldown-ms=150 { move-column-to-workspace-down; }
        Mod+Ctrl+WheelScrollUp cooldown-ms=150 { move-column-to-workspace-up; }

        Mod+1 { focus-workspace 1; }
        Mod+2 { focus-workspace 2; }
        Mod+3 { focus-workspace 3; }
        Mod+4 { focus-workspace 4; }
        Mod+5 { focus-workspace 5; }
        Mod+6 { focus-workspace 6; }
        Mod+7 { focus-workspace 7; }
        Mod+8 { focus-workspace 8; }
        Mod+9 { focus-workspace 9; }

        Mod+Ctrl+1 { move-column-to-workspace 1; }
        Mod+Ctrl+2 { move-column-to-workspace 2; }
        Mod+Ctrl+3 { move-column-to-workspace 3; }
        Mod+Ctrl+4 { move-column-to-workspace 4; }
        Mod+Ctrl+5 { move-column-to-workspace 5; }
        Mod+Ctrl+6 { move-column-to-workspace 6; }
        Mod+Ctrl+7 { move-column-to-workspace 7; }
        Mod+Ctrl+8 { move-column-to-workspace 8; }
        Mod+Ctrl+9 { move-column-to-workspace 9; }

        Mod+Tab { focus-workspace-previous; }

        // ─── Layout Controls ───
        Mod+R { switch-preset-column-width; }
        Mod+Shift+R { switch-preset-column-width-back; }
        Mod+Ctrl+F { expand-column-to-available-width; }
        Mod+C { center-column; }
        Mod+Ctrl+C { center-visible-columns; }
        Mod+Minus { set-column-width "-10%"; }
        Mod+Equal { set-column-width "+10%"; }
        Mod+Shift+Minus { set-window-height "-10%"; }
        Mod+Shift+Equal { set-window-height "+10%"; }

        // ─── Window Modes ───
        Mod+V { toggle-window-floating; }
        Mod+Shift+V { switch-focus-between-floating-and-tiling; }
        Mod+F { fullscreen-window; }
        Mod+M { maximize-column; }
        Mod+W { toggle-column-tabbed-display; }

        // ─── Screenshots (macOS style) ───
        // Super+Shift+3: Full screen
        Mod+Shift+3 { screenshot-screen; }
        // Super+Shift+4: Selection
        Mod+Shift+4 { screenshot; }
        // Super+Shift+S: Selection → Swappy (edit/annotate)
        Mod+Shift+S { spawn "sh" "-c" "grim -g \"$(slurp)\" - | swappy -f -"; }
        // Fallback Print keys
        Print { screenshot; }
        Ctrl+Print { screenshot-screen; }
        Alt+Print { screenshot-window; }

        // ─── System ───
        Mod+Shift+W hotkey-overlay-title="Next Wallpaper" { spawn "random-wallpaper"; }
        Mod+O repeat=false { toggle-overview; }
        Mod+Escape allow-inhibiting=false { toggle-keyboard-shortcuts-inhibit; }
        Mod+Shift+E { quit; }
        Ctrl+Alt+Delete { quit; }
        Mod+Shift+P { power-off-monitors; }

        // ─── Mouse Bindings ───
        // Default: column navigation
        MouseBack    { focus-column-left; }
        MouseForward { focus-column-right; }
        MouseMiddle  { toggle-overview; }

        // Ctrl + Mouse: Monitor focus
        Ctrl+MouseBack    { focus-monitor-left; }
        Ctrl+MouseForward { focus-monitor-right; }
        Ctrl+MouseMiddle  { focus-monitor-next; }

        // Alt + Mouse: Move window to monitor
        Alt+MouseBack    { move-column-to-monitor-left; }
        Alt+MouseForward { move-column-to-monitor-right; }
        Alt+MouseMiddle  { maximize-column; }

        // Super + Mouse: Workspace navigation
        Mod+MouseBack    { focus-workspace-up; }
        Mod+MouseForward { focus-workspace-down; }
        Mod+MouseMiddle  { toggle-window-floating; }
    }
  '';
}
