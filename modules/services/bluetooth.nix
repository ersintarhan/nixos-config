# Bluetooth Module
{ pkgs, ... }:

{
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;
  # Blueman manager (without tray applet)
  environment.systemPackages = [ pkgs.blueman ];
}
