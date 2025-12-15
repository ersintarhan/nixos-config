# Distrobox Containers Configuration

{
  programs.distrobox = {
    enable = true;

    # Global settings
    settings = {
      container_manager = "podman";
      container_always_pull = "0"; # Don't always pull, faster startup
      container_generate_entry = "1"; # Generate .desktop entries
      skip_workdir = "0";
    };

    containers = {
      # Debian Trixie - isolated dev environment
      # For postgresql, redis, testing etc.
      debian = {
        image = "debian:trixie";
        entry = true;
        init = true; # systemd enabled
        home = "~/.distrobox/home/debian"; # isolated home
        additional_packages = "git curl wget build-essential micro lnav";
      };

      # Arch Linux - shared home, quick access
      arch = {
        image = "archlinux:latest";
        entry = true;
        additional_packages = "base-devel git fish";
        init_hooks = [
          "git clone https://aur.archlinux.org/paru-bin.git /tmp/paru && cd /tmp/paru && makepkg -si --noconfirm && rm -rf /tmp/paru"
        ];
      };
    };
  };
}
