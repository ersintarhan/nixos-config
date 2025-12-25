# NixOS Configuration

My personal NixOS + Home Manager configuration with Flakes, featuring a modular structure and encrypted secrets management.

## Features

### System

- **Flakes** - Reproducible system configuration
- **Home Manager** - Declarative user environment management
- **Multi-host** - Same config, multiple machines (bosgame, ryzen)
- **sops-nix** - Encrypted secrets (SSH keys, kubeconfig, etc.)
- **Podman** - Docker-compatible container runtime
- **ZRAM** - Compressed RAM swap (32GB on bosgame)
- **BPFTune** - Auto-tune system with BPF

### Desktop

- **Niri** - Scrollable tiling Wayland compositor
- **Catppuccin/nix** - Unified Mocha theme with lavender accent across all apps
- **Waybar + Mako** - Status bar and notifications
- **Rofi** - App launcher with calculator and emoji plugins
- **swww** - Wallpaper management with random selection
- **Fish shell** - Modern shell with starship prompt
- **Nemo + Yazi** - File managers with custom actions
- **Multiple Terminals** - Kitty, Foot, Alacritty

### Development

- **.NET** - SDK and global tools (bosgame only)
- **Python** - Python + uv package manager
- **Node.js & Rust** - Runtime environments
- **AI Tools** - Codex CLI, ACP
- **Cloud Tools** - kubectl, Helm, k9s
- **Database Tools** - Full database development suite

### Hardware

- **ROCm** - AMD GPU compute support (bosgame only)
- **DDC/CI** - External monitor brightness control
- **Split DNS** - Consul + Cloudflare (Consul + Cloudflare)

## Structure

```
nixos-config/
├── flake.nix                 # Main flake (defines hosts)
├── flake.lock                # Dependency lock
├── .sops.yaml                # SOPS GPG key configuration
│
├── hosts/                    # Machine-specific NixOS configs
│   ├── bosgame/
│   │   ├── default.nix       # Host config (ROCm GPU)
│   │   └── hardware.nix      # Hardware (generated)
│   └── ryzen/
│       ├── default.nix       # Host config (integrated GPU)
│       └── hardware.nix      # Hardware (generated)
│
├── modules/                  # Shared NixOS modules
│   ├── desktop/
│   │   ├── default.nix       # Niri, portals, fonts, greetd
│   │   └── packages.nix      # System packages
│   ├── hardware/
│   │   ├── graphics.nix      # AMD GPU with ROCm
│   │   └── graphics-basic.nix # AMD GPU without ROCm
│   ├── development/
│   │   ├── dotnet.nix        # .NET SDK + global tools
│   │   ├── python.nix        # Python + uv
│   │   ├── ai-tools.nix      # Codex CLI + ACP
│   │   ├── database.nix      # Database tools
│   │   └── cloud.nix         # Cloud tools
│   └── services/
│       ├── audio.nix         # Pipewire
│       ├── bluetooth.nix     # Bluetooth + Blueman
│       └── dns.nix           # Split DNS (Consul + Cloudflare)
│
├── home/                     # Home Manager configs
│   └── ersin/
│       ├── default.nix       # Main entry (imports modules by hostname)
│       │
│       ├── core/             # Shell & CLI tools
│       │   ├── default.nix   # Imports + env vars, zoxide, bat, etc.
│       │   ├── fish.nix      # Fish shell + abbreviations
│       │   ├── bash.nix      # Bash config
│       │   ├── starship.nix  # Prompt
│       │   ├── git.nix       # Git config
│       │   ├── ssh.nix       # SSH config
│       │   ├── eza.nix       # Modern ls
│       │   ├── vivid.nix     # LS_COLORS
│       │   └── k9s.nix       # Kubernetes TUI
│       │
│       ├── desktop/          # Wayland desktop environment
│       │   ├── default.nix   # Imports + GTK/Qt themes
│       │   ├── niri.nix      # Compositor & keybindings
│       │   ├── waybar.nix    # Status bar
│       │   ├── mako.nix      # Notifications
│       │   ├── rofi.nix      # App launcher
│       │   ├── fuzzel.nix    # Fuzzel (backup launcher)
│       │   ├── wallpaper.nix # Random wallpaper service
│       │   └── scripts/      # Desktop scripts
│       │
│       ├── terminals/        # Terminal emulators
│       │   ├── kitty.nix
│       │   ├── foot.nix
│       │   └── alacritty.nix
│       │
│       ├── editors/          # Text editors
│       │   ├── micro.nix
│       │   └── zed.nix
│       │
│       ├── browsers/         # Web browsers
│       │   └── firefox.nix
│       │
│       ├── email/            # Email client
│       │   └── thunderbird.nix
│       │
│       ├── theme/            # Theming
│       │   └── catppuccin.nix
│       │
│       ├── containers/       # Container tools
│       │   └── distrobox.nix
│       │
│       ├── secrets/          # Secret management
│       │   └── sops.nix
│       │
│       └── hosts/            # Host-specific home config
│           ├── bosgame.nix   # ROCm tools
│           └── ryzen.nix     # Lightweight
│
└── secrets/                  # Encrypted secrets (safe to commit)
    └── secrets.yaml          # SSH keys, kubeconfig (GPG encrypted)
```

## Hosts

### bosgame - Main Workstation

[🔗 Hardware Probe](https://linux-hardware.org/?probe=a0cd9bd643)

| Component    | Specification                                              |
| ------------ | ---------------------------------------------------------- |
| **Model**    | Bosgame AXB35-02 Mini PC                                   |
| **CPU**      | AMD Ryzen AI MAX+ 395 (32 cores / 64 threads)              |
| **GPU**      | AMD Radeon 8060S (Strix Halo, RDNA 3.5)                    |
| **NPU**      | AMD XDNA Neural Processing Unit                            |
| **RAM**      | 128GB LPDDR5 8000MT/s (8×16GB Samsung)                     |
| **Storage**  | 2TB Kingston NVMe                                          |
| **Network**  | Realtek RTL8125 2.5GbE + MediaTek WiFi                     |
| **Ports**    | USB4/Thunderbolt, USB-C, USB-A                             |
| **Features** | ROCm, .NET, Python, AI tools, ZRAM (32GB), BPFTune, DDC/CI |
| **Modules**  | graphics.nix (ROCm enabled)                                |

**System Services**:

- ROCm GPU compute (rocm-smi, nvtop)
- .NET SDK + global tools
- Python + uv
- AI tools (Codex CLI, ACP)
- Database tools
- Cloud tools (kubectl, Helm)
- ZRAM compressed swap (32GB)
- BPFTune auto-tuning
- DDC/CI monitor control
- Split DNS (Consul + Cloudflare)

### ryzen - Secondary Mini PC

[🔗 Hardware Probe](https://linux-hardware.org/?probe=52b73c2ad7)

| Component    | Specification                                |
| ------------ | -------------------------------------------- |
| **Model**    | HM24 Mini-PC HM247837                        |
| **CPU**      | AMD Ryzen 9 6900HX (8 cores / 16 threads)    |
| **GPU**      | AMD Radeon 680M (Rembrandt, RDNA 2)          |
| **RAM**      | 64GB DDR5 5600MT/s (2×32GB Kingston)         |
| **Storage**  | 1TB Kingston NV2 NVMe                        |
| **Network**  | Intel I226-V 2.5GbE + Realtek RTL8851BE WiFi |
| **Ports**    | USB4/Thunderbolt, USB-C, USB-A               |
| **Features** | Lightweight, basic graphics                  |
| **Modules**  | graphics-basic.nix (no ROCm)                 |

**System Services**:

- Basic AMD GPU (no ROCm)
- Minimal development tools

## Quick Start

### Prerequisites

- NixOS installed with flakes enabled
- GPG key imported (for secret decryption)

### Installation

```bash
# Clone the repo
git clone https://github.com/ersinergin/nixos-config.git ~/nixos-config
cd ~/nixos-config

# Generate hardware config for your machine
nixos-generate-config --show-hardware-config > hosts/HOSTNAME/hardware.nix

# Import your GPG key
gpg --import /path/to/your-key.asc
gpg --edit-key YOUR_KEY_ID  # trust -> 5 -> quit

# Apply configuration
sudo nixos-rebuild switch --flake .#HOSTNAME
```

### Daily Usage

```bash
# Update system (fish abbreviation - auto-detects hostname)
update

# Clean old generations
cleanup

# Edit secrets
sops secrets/secrets.yaml

# Manual rebuild
sudo nixos-rebuild switch --flake ~/nixos-config#bosgame

# Change wallpaper
random-wallpaper
```

## Development Tools

### .NET (bosgame only)

- Full .NET SDK
- Global tools via `dotnet tool list`
- Rider IDE integration

### Python

- Python interpreter
- `uv` package manager (modern alternative to pip)
- Development tools

### AI/ML

- Codex CLI
- ACP (AI Code Prettier)
- HuggingFace models cached to `~/models/huggingface`

### Cloud & DevOps

- kubectl
- Helm
- k9s (Kubernetes TUI)
- Cloud CLI tools

### Databases

- Full database development suite
- Multiple database clients

## Desktop Features

### Window Management (Niri)

- Scrollable tiling layout
- Keyboard-driven window control
- Automatic window rules (floating for dialogs)
- Smooth animations
- Multi-monitor support

### File Manager Integration

**Nemo Actions** (right-click menu):

- Copy Full Path
- Copy Directory Path
- Open in Zed
- Open in Antigravity AI
- Open Terminal Here (Foot)

**Custom MIME Types**:

- `.sln`, `.csproj`, `.fsproj` → JetBrains Rider
- HTML, HTTP, HTTPS → Brave
- Directories → Nemo
- Email → Thunderbird

### Terminal Emulators

- **Foot**: Lightweight Wayland-native (primary)
- **Kitty**: Feature-rich GPU-accelerated
- **Alacritty**: Fast GPU-accelerated (backup)

### Editors

- **Zed**: Modern AI-powered editor (primary)
- **Micro**: Nano-like, cross-platform (quick edits)

### Browsers

- **Brave**: Primary browser
- **Microsoft Edge**: Secondary (installed via Flatpak)

### Email

- **Thunderbird**: Email client with GPG integration

### Wallpaper

- swww daemon (systemd service)
- Random wallpaper script
- Manual change with `random-wallpaper`

## System Features

### Container Runtime

```bash
# Podman (Docker-compatible)
podman run hello-world

# Distrobox (Arch Linux container)
distrobox enter arch
```

### GPU Monitoring (bosgame)

```bash
# ROCm GPU stats
rocm-smi

# Interactive GPU monitor
nvtop
```

### Split DNS

- **Consul**: Local services resolution
- **Cloudflare**: External DNS
- Automatic routing based on domain

### Compressed Swap (bosgame)

- 32GB ZRAM swap
- Reduces memory pressure
- Compressed RAM swap

### Auto-Tuning

- **BPFTune**: System auto-tuning with BPF
- Automatic kernel parameter optimization

### Monitor Control

```bash
# DDC/CI support for external monitors
brightnessctl set +10%
brightnessctl set 10-%
```

## Keybindings (Niri)

### Applications

| Key           | Action               |
| ------------- | -------------------- |
| `Mod+Return`  | Foot terminal        |
| `Mod+T`       | Kitty terminal       |
| `Mod+Shift+T` | Alacritty terminal   |
| `Mod+Space`   | Rofi launcher (drun) |
| `Mod+D`       | Rofi launcher (drun) |
| `Mod+E`       | Nemo file manager    |
| `Mod+Y`       | Yazi file manager    |
| `Mod+B`       | Brave browser        |
| `Mod+Shift+B` | Microsoft Edge       |
| `Super+Alt+L` | Lock screen          |

### Audio Controls

| Key                    | Action                 |
| ---------------------- | ---------------------- |
| `XF86AudioRaiseVolume` | Volume +10% (max 100%) |
| `XF86AudioLowerVolume` | Volume -10%            |
| `XF86AudioMute`        | Toggle mute            |
| `XF86AudioMicMute`     | Toggle mic mute        |
| `XF86AudioPlay/Pause`  | Play/Pause             |
| `XF86AudioNext`        | Next track             |
| `XF86AudioPrev`        | Previous track         |

### Brightness Controls

| Key                     | Action          |
| ----------------------- | --------------- |
| `XF86MonBrightnessUp`   | Brightness +10% |
| `XF86MonBrightnessDown` | Brightness -10% |

### Window Management

| Key                                 | Action               |
| ----------------------------------- | -------------------- |
| `Mod+Q`                             | Close window         |
| `Mod+Left/H`                        | Focus column left    |
| `Mod+Right/L`                       | Focus column right   |
| `Mod+Up/K`                          | Focus window up      |
| `Mod+Down/J`                        | Focus window down    |
| `Mod+Ctrl+Left/H`                   | Move column left     |
| `Mod+Ctrl+Right/L`                  | Move column right    |
| `Mod+Ctrl+Up/K`                     | Move window up       |
| `Mod+Ctrl+Down/J`                   | Move window down     |
| `Mod+Comma`                         | Consume column left  |
| `Mod+Period`                        | Consume column right |
| `Mod+Home`                          | Focus first column   |
| `Mod+End`                           | Focus last column    |
| `Mod+Ctrl+Home`                     | Move column to first |
| `Mod+Ctrl+End`                      | Move column to last  |
| `Mod+Shift+Left/Right/Up/Down`      | Focus monitor        |
| `Mod+Shift+Ctrl+Left/Right/Up/Down` | Move to monitor      |

### Workspaces

| Key                      | Action                   |
| ------------------------ | ------------------------ |
| `Mod+1-9`                | Switch to workspace      |
| `Mod+Ctrl+1-9`           | Move column to workspace |
| `Mod+Tab`                | Previous workspace       |
| `Mod+WheelScrollUp/Down` | Navigate workspaces      |

### Layout Controls

| Key             | Action                     |
| --------------- | -------------------------- |
| `Mod+R`         | Switch preset column width |
| `Mod+Shift+R`   | Previous preset            |
| `Mod+Ctrl+F`    | Expand to available width  |
| `Mod+C`         | Center column              |
| `Mod+Ctrl+C`    | Center all columns         |
| `Mod+-/=`       | Set column width ±10%      |
| `Mod+Shift+-/=` | Set window height ±10%     |
| `Mod+M`         | Maximize column            |
| `Mod+W`         | Toggle tabbed display      |

### Window Modes

| Key           | Action                |
| ------------- | --------------------- |
| `Mod+V`       | Toggle floating       |
| `Mod+Shift+V` | Focus floating/tiling |
| `Mod+F`       | Fullscreen            |
| `Mod+O`       | Toggle overview       |

### Screenshots

| Key           | Action                        |
| ------------- | ----------------------------- |
| `Mod+Shift+3` | Full screen screenshot        |
| `Mod+Shift+4` | Area selection screenshot     |
| `Mod+Shift+S` | Area → Swappy (edit/annotate) |
| `Print`       | Area selection screenshot     |
| `Ctrl+Print`  | Full screen screenshot        |
| `Alt+Print`   | Window screenshot             |

### Clipboard & Other

| Key               | Action                   |
| ----------------- | ------------------------ |
| `Mod+Shift+C`     | Clipboard history (Rofi) |
| `Mod+Shift+W`     | Next wallpaper           |
| `Mod+Escape`      | Reload config            |
| `Mod+Shift+E`     | Quit session             |
| `Ctrl+Alt+Delete` | Quit session             |
| `Mod+Shift+P`     | Power off monitors       |

### Mouse Bindings

| Mouse               | Action             |
| ------------------- | ------------------ |
| `Back`              | Focus column left  |
| `Forward`           | Focus column right |
| `Middle`            | Toggle overview    |
| `Ctrl+Back/Forward` | Focus monitor      |
| `Alt+Back/Forward`  | Move to monitor    |
| `Mod+Middle`        | Maximize to edges  |

### Rofi Modes

- **drun** - Application launcher (default)
- **run** - Run commands
- **calc** - Calculator
- **emoji** - Emoji picker

Press `Ctrl+Tab` in Rofi to switch between modes.

## Niri Advanced Features

### Window Rules

Automatic floating rules:

- Firefox PiP windows
- Network manager dialog
- Bluetooth manager
- Audio mixer (pavucontrol)
- XDG portal dialogs

No rounded corners on any windows.

### Animations

- Smooth workspace switching (spring)
- Window open/close (200ms)
- Layout transitions (spring)
- Window movement/resize (spring)

### Environment Variables

- `DISPLAY:1` - Xwayland display
- `ELECTRON_OZONE_PLATFORM_HINT:auto` - Electron apps
- `QT_QPA_PLATFORM:wayland` - Qt apps
- `GTK_THEME:Adwaita:dark` - GTK theme

## Secret Management

Secrets are encrypted with [sops-nix](https://github.com/Mic92/sops-nix) using GPG:

```bash
# Edit/add secrets
sops secrets/secrets.yaml

# Secrets are automatically decrypted during rebuild to:
# ~/.kube/config      - Kubernetes config
# ~/.ssh/id_ed25519   - SSH private key
# ~/.ssh/id_rsa       - SSH private key (legacy)
```

## Useful Commands

```bash
# Update flake inputs
nix flake update

# Search packages
nix search nixpkgs package-name

# Rollback to previous generation
sudo nixos-rebuild switch --rollback

# List generations
sudo nix-env --list-generations --profile /nix/var/nix/profiles/system

# Garbage collect
sudo nix-collect-garbage -d

# Check GPU (bosgame only)
rocm-smi
nvtop

# System info
fastfetch

# Distrobox (Arch)
distrobox enter arch

# Container management
podman ps
podman images

# Wallpaper
random-wallpaper

# Monitor brightness
brightnessctl set +10%
brightnessctl set 10-%

# Audio control
wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.1+
wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle

# Media control
playerctl play-pause
playerctl next
playerctl previous
```

## Catppuccin Theme

This config uses [catppuccin/nix](https://github.com/catppuccin/nix) for unified theming:

```nix
# home/ersin/theme/catppuccin.nix
catppuccin = {
  enable = true;
  flavor = "mocha";
  accent = "lavender";
};
```

Apps automatically themed: bat, btop, fish, starship, k9s, vivid, firefox, micro, fzf, and more.

## Adding a New Host

1. Create host directory:

```bash
mkdir -p hosts/newhost
```

2. Generate hardware config on the new machine:

```bash
nixos-generate-config --show-hardware-config > hosts/newhost/hardware.nix
```

3. Create `hosts/newhost/default.nix`:

```nix
{ config, pkgs, ... }:

{
  imports = [
    ./hardware.nix
    ../../modules/desktop
    ../../modules/services/audio.nix
    ../../modules/services/bluetooth.nix
    ../../modules/hardware/graphics-basic.nix  # or graphics.nix for ROCm
    # Add development modules as needed:
    # ../../modules/development/dotnet.nix
    # ../../modules/development/python.nix
  ];

  networking.hostName = "newhost";
  # ... rest of config
}
```

4. Create `home/ersin/hosts/newhost.nix`:

```nix
# Host-specific home configuration
{ config, pkgs, lib, ... }:

{
  # Add host-specific packages or settings
  home.packages = with pkgs; [
    # ...
  ];
}
```

5. Add to `flake.nix`:

```nix
newhost = nixpkgs.lib.nixosSystem {
  system = "x86_64-linux";
  specialArgs = { inherit inputs; };
  modules = [
    ./hosts/newhost
    sops-nix.nixosModules.sops
    catppuccin.nixosModules.catppuccin
    home-manager.nixosModules.home-manager
    {
      home-manager.useGlobalPkgs = true;
      home-manager.useUserPackages = true;
      home-manager.users.ersin = import ./home/ersin;
      home-manager.sharedModules = [
        sops-nix.homeManagerModules.sops
        catppuccin.homeModules.catppuccin
      ];
      home-manager.extraSpecialArgs = { inherit inputs; hostname = "newhost"; };
    }
  ];
};
```

6. Apply on the new machine:

```bash
sudo nixos-rebuild switch --flake ~/nixos-config#newhost
```

## Acknowledgments

- [NixOS](https://nixos.org/)
- [Home Manager](https://github.com/nix-community/home-manager)
- [sops-nix](https://github.com/Mic92/sops-nix)
- [Niri](https://github.com/YaLTeR/niri)
- [Catppuccin](https://github.com/catppuccin/catppuccin)
- [catppuccin/nix](https://github.com/catppuccin/nix)

## License

MIT
