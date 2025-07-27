{ ... }:
{
  imports = [
    ./bluetooth.nix
    ./bootloader.nix
    ./flatpak.nix
    ./hardware.nix
    ./ledger.nix              # Ledger hardware support
    ./mnt-data-ownership.nix
    ./network.nix
    ./nh.nix
    ./pipewire.nix
    ./program.nix
    ./rclone.nix
    ./security.nix
    ./services.nix
    ./steam.nix
    ./system.nix
    ./user.nix
    ./virtualization.nix
    ./wayland.nix
    ./xserver.nix
    ./zram.nix                # zram for temporary /tmp
  ];
}
