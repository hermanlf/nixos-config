{ config, pkgs, ... }:

{
  home.file.".config/waybar/scripts/bluetooth.sh" = {
    text = ''
    #!/usr/bin/env bash

    powered=$(bluetoothctl show | grep "Powered: yes")
    if [[ -n "$powered" ]]; then
        # Bluetooth is on
        echo '{"text": "<span color=\"#458588\"></span> <span color=\"#FBF1C7\">On </span>"}'
    else
        # Bluetooth is off
        echo '{"text": "<span color=\"#458588\"></span> <span color=\"#FBF1C7\">Off </span>"}'
    fi
    '';
    executable = true;
  };
}
