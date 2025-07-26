# nixos-config/modules/core/ledger.nix
{ ... }:
{
  # Enable hardware support for Ledger devices
  hardware.ledger.enable = true;

  # Add user to plugdev group for USB device access
  users.users.hermanlf = {
    extraGroups = [ "plugdev" ];
  };

  # Additional udev rules for better Ledger device support
  services.udev.extraRules = ''
    # Ledger Nano S
    SUBSYSTEMS=="usb", ATTRS{idVendor}=="2c97", ATTRS{idProduct}=="0001", MODE="0660", TAG+="uaccess", TAG+="udev-acl"
    # Ledger Nano X
    SUBSYSTEMS=="usb", ATTRS{idVendor}=="2c97", ATTRS{idProduct}=="0004", MODE="0660", TAG+="uaccess", TAG+="udev-acl"
    # Ledger Nano S Plus
    SUBSYSTEMS=="usb", ATTRS{idVendor}=="2c97", ATTRS{idProduct}=="0005", MODE="0660", TAG+="uaccess", TAG+="udev-acl"
    # Ledger Blue
    SUBSYSTEMS=="usb", ATTRS{idVendor}=="2c97", ATTRS{idProduct}=="0000", MODE="0660", TAG+="uaccess", TAG+="udev-acl"
  '';
}
