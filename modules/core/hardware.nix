{ config, lib, pkgs, ... }:
{
  # Enable OpenGL
  hardware.graphics = {
    enable = true;
  };
  
  # Load nvidia driver for Xorg and Wayland
  services.xserver.videoDrivers = ["nvidia"];
  
  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = false;
    powerManagement.finegrained = false;
    open = false;
    nvidiaSettings = true;
  };
}
