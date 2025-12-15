# Basic Graphics Module (AMD integrated - no ROCm)
{ pkgs, config, ... }:

{
  # Enable graphics
  hardware.graphics = {
    enable = true;
    enable32Bit = true;

    extraPackages = with pkgs; [
      # Vulkan
      vulkan-loader
      vulkan-validation-layers

      # VA-API (video acceleration)
      libva
      libva-utils
    ];

    extraPackages32 = with pkgs.pkgsi686Linux; [
      vulkan-loader
    ];
  };

  # AMD CPU microcode
  hardware.cpu.amd.updateMicrocode = true;

  # Firmware
  hardware.enableRedistributableFirmware = true;

  # Useful GPU tools
  environment.systemPackages = with pkgs; [
    mesa-demos # glxinfo, glxgears etc.
    vulkan-tools
    nvtopPackages.amd
  ];
}
