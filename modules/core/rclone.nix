{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    rclone
  ];
}

