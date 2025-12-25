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

  };
}
