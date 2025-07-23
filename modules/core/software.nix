{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    nwg-look # for theming GTK
    libsForQt5.qt5ct # for theming qt5
    kdePackages.qt6ct # for theming qt6
    rPackages.fuser # fuser required for rclone
  ];
}

