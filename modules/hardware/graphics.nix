# Graphics Module (AMD Radeon 8060S - Strix Point)
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

      # ROCm (OpenCL)
      rocmPackages.clr
      rocmPackages.clr.icd
    ];

    extraPackages32 = with pkgs.pkgsi686Linux; [
      vulkan-loader
    ];
  };

  # AMD CPU microcode
  hardware.cpu.amd.updateMicrocode = true;

  # Firmware
  hardware.enableRedistributableFirmware = true;

  # Environment variables (RADV is default now)
  environment.variables = {
    # HSA_OVERRIDE_GFX_VERSION = "11.0.0";  # Uncomment if ROCm doesn't detect GPU
  };

  # Useful GPU tools
  environment.systemPackages = with pkgs; [
    mesa-demos # glxinfo, glxgears etc.
    vulkan-tools
    libva-utils # vainfo
    clinfo
    nvtopPackages.amd

    # ROCm tools
    rocmPackages.rocminfo
    rocmPackages.rocm-smi
  ];
}
