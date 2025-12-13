# NixOS Configuration

Ersin'in modüler NixOS + Home Manager yapılandırması.

## Yapı

```
nixos-config/
├── flake.nix                 # Ana flake dosyası
├── flake.lock                # Bağımlılık kilidi
├── hosts/                    # Bilgisayar-spesifik ayarlar
│   ├── bosgame/
│   │   ├── default.nix       # Host yapılandırması
│   │   └── hardware.nix      # Donanım (nixos-generate-config ile oluşur)
│   └── ryzen/                # (Yeni host için örnek)
│       ├── default.nix
│       └── hardware.nix
├── modules/                  # Paylaşılan modüller
│   ├── desktop/
│   │   ├── default.nix       # Niri, portals, fonts
│   │   └── packages.nix      # Sistem paketleri
│   ├── hardware/
│   │   └── graphics.nix      # GPU ayarları (AMD)
│   └── services/
│       ├── audio.nix         # Pipewire
│       └── bluetooth.nix     # Bluetooth
└── home/                     # Home Manager (kullanıcı ayarları)
    └── ersin/
        ├── default.nix       # Ana home config
        ├── programs.nix      # Git, Fish, SSH, GPG, vs.
        ├── niri.nix          # Niri compositor config
        ├── waybar.nix        # Status bar
        └── mako.nix          # Bildirimler
```

## Günlük Kullanım

```bash
# Sistemi güncelle
update

# Eski nesilleri temizle
cleanup

# Manuel güncelleme
sudo nixos-rebuild switch --flake ~/nixos-config#bosgame
```

## Yeni Paket Ekleme

`modules/desktop/packages.nix` dosyasını düzenle:

```nix
environment.systemPackages = with pkgs; [
  # ... mevcut paketler
  yeni-paket
];
```

Sonra `update` çalıştır.

## Yeni Host Ekleme (örn: ryzen)

### 1. Host klasörü oluştur

```bash
mkdir -p ~/nixos-config/hosts/ryzen
```

### 2. Yeni makinede hardware config oluştur

```bash
nixos-generate-config --show-hardware-config > hardware.nix
```

Bu dosyayı `hosts/ryzen/hardware.nix` olarak kopyala.

### 3. Host config oluştur

`hosts/ryzen/default.nix`:

```nix
{ config, pkgs, ... }:

{
  imports = [
    ./hardware.nix
    ../../modules/desktop
    ../../modules/services/audio.nix
    ../../modules/services/bluetooth.nix
    ../../modules/hardware/graphics.nix  # GPU'ya göre değiştir
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelPackages = pkgs.linuxPackages_latest;

  networking.hostName = "ryzen";  # Hostname
  networking.networkmanager.enable = true;

  time.timeZone = "Europe/Istanbul";
  i18n.defaultLocale = "en_US.UTF-8";

  programs.fish.enable = true;
  users.users.ersin = {
    isNormalUser = true;
    description = "Ersin Tarhan";
    extraGroups = [ "networkmanager" "wheel" "video" "audio" ];
    shell = pkgs.fish;
  };
  security.sudo.wheelNeedsPassword = false;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config.allowUnfree = true;

  system.stateVersion = "25.11";  # İlk kurulum versiyonu
}
```

### 4. flake.nix'e host ekle

```nix
nixosConfigurations = {
  bosgame = nixpkgs.lib.nixosSystem { ... };

  # Yeni host
  ryzen = nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";
    specialArgs = { inherit inputs; };
    modules = [
      ./hosts/ryzen
      home-manager.nixosModules.home-manager
      {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.users.ersin = import ./home/ersin;
      }
    ];
  };
};
```

### 5. Yeni makinede uygula

```bash
sudo nixos-rebuild switch --flake ~/nixos-config#ryzen
```

## Kısayollar (Niri)

| Kısayol | Eylem |
|---------|-------|
| `Mod+Return` | Kitty terminal |
| `Mod+T` | Foot terminal |
| `Mod+Space` | Fuzzel (uygulama başlatıcı) |
| `Mod+E` | Nemo (dosya yöneticisi) |
| `Mod+Y` | Yazi (TUI dosya yöneticisi) |
| `Mod+B` | Firefox |
| `Mod+Q` | Pencere kapat |
| `Mod+F` | Tam ekran |
| `Mod+V` | Float/tile geçiş |
| `Mod+1-9` | Workspace değiştir |
| `Mod+Tab` | Önceki workspace |
| `Print` | Screenshot |
| `Mod+O` | Overview |

## Faydalı Komutlar

```bash
# Nix store temizle
sudo nix-collect-garbage -d

# Flake güncelle (nixpkgs vs.)
nix flake update

# Belirli bir input güncelle
nix flake lock --update-input nixpkgs

# Önceki nesile dön
sudo nixos-rebuild switch --rollback

# Mevcut nesilleri listele
sudo nix-env --list-generations --profile /nix/var/nix/profiles/system

# Paket ara
nix search nixpkgs paket-adi

# GPU durumu
nvtop
rocm-smi

# Sistem bilgisi
fastfetch
```

## Dosya Konumları

| Dosya | Açıklama |
|-------|----------|
| `~/.config/niri/config.kdl` | Niri config (Home Manager yönetir) |
| `~/.config/waybar/` | Waybar config (Home Manager yönetir) |
| `~/.ssh/` | SSH anahtarları (manuel) |
| `~/.gnupg/` | GPG anahtarları (manuel) |

## Notlar

- Private key'leri (SSH, GPG) git'e **ekleme**
- `hardware.nix` her makinede farklı olacak
- `system.stateVersion` değiştirme (ilk kurulum versiyonu)
- Değişikliklerden sonra `update` çalıştır
