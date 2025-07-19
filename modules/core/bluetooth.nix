{ config, pkgs, ... }:

{
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };

  services.blueman.enable = true;

  # systemd should manage bluetooth
  services.dbus.packages = [ pkgs.blueman ];
}
