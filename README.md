# NixOS Configuration

My personal NixOS + Home Manager configuration with Flakes, featuring a modular structure and encrypted secrets management.

## Features

- **Flakes** - Reproducible system configuration
- **Home Manager** - Declarative user environment management
- **Multi-host** - Same config, multiple machines (bosgame, ryzen)
- **sops-nix** - Encrypted secrets (SSH keys, kubeconfig, etc.)
- **Catppuccin/nix** - Unified Mocha theme with lavender accent across all apps
- **Niri** - Scrollable tiling Wayland compositor
- **Waybar + Mako** - Status bar and notifications
- **Rofi** - App launcher with calculator and emoji plugins
- **Fish shell** - Modern shell with starship prompt
- **ROCm** - AMD GPU compute support (bosgame only)
- **Distrobox** - Arch Linux container for AUR packages
- **Development tools** - Node.js, Rust, Python, .NET, kubectl, Helm

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
│   │   ├── default.nix       # Niri, portals, fonts
│   │   └── packages.nix      # System packages
│   ├── hardware/
│   │   ├── graphics.nix      # AMD GPU with ROCm
│   │   └── graphics-basic.nix # AMD GPU without ROCm
│   └── services/
│       ├── audio.nix         # Pipewire
│       └── bluetooth.nix     # Bluetooth + Blueman
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
│       │   └── wallpaper.nix # Random wallpaper service
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

| Component | Specification |
|-----------|---------------|
| **Model** | Bosgame AXB35-02 Mini PC |
| **CPU** | AMD Ryzen AI MAX+ 395 (32 cores / 64 threads) |
| **GPU** | AMD Radeon 8060S (Strix Halo, RDNA 3.5) |
| **NPU** | AMD XDNA Neural Processing Unit |
| **RAM** | 128GB LPDDR5 8000MT/s (8×16GB Samsung) |
| **Storage** | 2TB Kingston NVMe |
| **Network** | Realtek RTL8125 2.5GbE + MediaTek WiFi |
| **Ports** | USB4/Thunderbolt, USB-C, USB-A |
| **Graphics Module** | `graphics.nix` (ROCm enabled) |

### ryzen - Secondary Mini PC

[🔗 Hardware Probe](https://linux-hardware.org/?probe=52b73c2ad7)

| Component | Specification |
|-----------|---------------|
| **Model** | HM24 Mini-PC HM247837 |
| **CPU** | AMD Ryzen 9 6900HX (8 cores / 16 threads) |
| **GPU** | AMD Radeon 680M (Rembrandt, RDNA 2) |
| **RAM** | 64GB DDR5 5600MT/s (2×32GB Kingston) |
| **Storage** | 1TB Kingston NV2 NVMe |
| **Network** | Intel I226-V 2.5GbE + Realtek RTL8851BE WiFi |
| **Ports** | USB4/Thunderbolt, USB-C, USB-A |
| **Graphics Module** | `graphics-basic.nix` (no ROCm) |

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
```

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

## Keybindings (Niri)

| Key | Action |
|-----|--------|
| `Mod+Return` | Foot terminal |
| `Mod+T` | Kitty terminal |
| `Mod+Shift+T` | Alacritty terminal |
| `Mod+Space` | Rofi launcher |
| `Mod+D` | Rofi launcher |
| `Mod+E` | Nemo file manager |
| `Mod+Y` | Yazi file manager |
| `Mod+B` | Microsoft Edge |
| `Mod+Q` | Close window |
| `Mod+F` | Fullscreen |
| `Mod+V` | Toggle float |
| `Mod+1-9` | Switch workspace |
| `Mod+Shift+1-9` | Move to workspace |
| `Print` | Screenshot (area) |
| `Mod+Print` | Screenshot (window) |
| `Mod+O` | Overview |
| `Super+Alt+L` | Lock screen |

### Rofi Modes

- **drun** - Application launcher (default)
- **run** - Run commands
- **calc** - Calculator
- **emoji** - Emoji picker

Press `Ctrl+Tab` in Rofi to switch between modes.

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

## Acknowledgments

- [NixOS](https://nixos.org/)
- [Home Manager](https://github.com/nix-community/home-manager)
- [sops-nix](https://github.com/Mic92/sops-nix)
- [Niri](https://github.com/YaLTeR/niri)
- [Catppuccin](https://github.com/catppuccin/catppuccin)
- [catppuccin/nix](https://github.com/catppuccin/nix)

## License

MIT
