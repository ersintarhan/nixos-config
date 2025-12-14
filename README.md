# NixOS Configuration

My personal NixOS + Home Manager configuration with Flakes, featuring a modular structure and encrypted secrets management.

## Features

- **Flakes** - Reproducible system configuration
- **Home Manager** - Declarative user environment management
- **sops-nix** - Encrypted secrets (SSH keys, kubeconfig, etc.)
- **Niri** - Scrollable tiling Wayland compositor
- **Waybar + Mako** - Status bar and notifications
- **Fish shell** - Modern shell with starship prompt
- **Catppuccin Mocha** - Consistent dark theme across apps
- **ROCm** - AMD GPU compute support
- **Development tools** - Node.js, Rust, Python, kubectl, Helm

## Structure

```
nixos-config/
├── flake.nix                 # Main flake
├── flake.lock                # Dependency lock
├── .sops.yaml                # SOPS GPG key configuration
│
├── hosts/                    # Machine-specific configs
│   └── bosgame/
│       ├── default.nix       # Host configuration
│       └── hardware.nix      # Hardware (generated)
│
├── modules/                  # Shared modules
│   ├── desktop/
│   │   ├── default.nix       # Niri, portals, fonts
│   │   └── packages.nix      # System packages
│   ├── hardware/
│   │   └── graphics.nix      # AMD GPU (ROCm, Vulkan)
│   └── services/
│       ├── audio.nix         # Pipewire
│       └── bluetooth.nix     # Bluetooth + Blueman
│
├── home/                     # Home Manager configs
│   └── ersin/
│       ├── default.nix       # Main home config, themes
│       ├── programs.nix      # Git, Fish, SSH, Kitty, etc.
│       ├── secrets.nix       # SOPS secret definitions
│       ├── niri.nix          # Compositor keybindings
│       ├── waybar.nix        # Status bar
│       └── mako.nix          # Notifications
│
└── secrets/                  # Encrypted secrets (safe to commit)
    └── secrets.yaml          # SSH keys, kubeconfig (GPG encrypted)
```

## Quick Start

### Prerequisites

- NixOS installed with flakes enabled
- GPG key imported (for secret decryption)

### Installation

```bash
# Clone the repo
git clone https://github.com/yourusername/nixos-config.git ~/nixos-config
cd ~/nixos-config

# Import your GPG key
gpg --import /path/to/your-key.asc
gpg --edit-key YOUR_KEY_ID  # trust -> 5 -> quit

# Apply configuration
sudo nixos-rebuild switch --flake .#bosgame
```

### Daily Usage

```bash
# Update system (fish abbreviation)
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
    ../../modules/hardware/graphics.nix
  ];

  networking.hostName = "newhost";
  # ... rest of config
}
```

4. Add to `flake.nix`:
```nix
nixosConfigurations = {
  newhost = nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";
    specialArgs = { inherit inputs; };
    modules = [
      ./hosts/newhost
      sops-nix.nixosModules.sops
      home-manager.nixosModules.home-manager
      {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.users.ersin = import ./home/ersin;
        home-manager.sharedModules = [
          sops-nix.homeManagerModules.sops
        ];
      }
    ];
  };
};
```

5. Apply on the new machine:
```bash
sudo nixos-rebuild switch --flake ~/nixos-config#newhost
```

## Keybindings (Niri)

| Key | Action |
|-----|--------|
| `Mod+Return` | Kitty terminal |
| `Mod+T` | Foot terminal |
| `Mod+Space` | Fuzzel launcher |
| `Mod+E` | Nemo file manager |
| `Mod+B` | Firefox |
| `Mod+Q` | Close window |
| `Mod+F` | Fullscreen |
| `Mod+V` | Toggle float |
| `Mod+1-9` | Switch workspace |
| `Mod+Shift+1-9` | Move to workspace |
| `Print` | Screenshot |
| `Mod+O` | Overview |

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

# Check GPU
rocm-smi
nvtop

# System info
fastfetch
```

## Acknowledgments

- [NixOS](https://nixos.org/)
- [Home Manager](https://github.com/nix-community/home-manager)
- [sops-nix](https://github.com/Mic92/sops-nix)
- [Niri](https://github.com/YaLTeR/niri)
- [Catppuccin](https://github.com/catppuccin/catppuccin)

## License

MIT
