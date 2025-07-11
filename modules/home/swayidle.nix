{ config, pkgs, ... }:

let
  lockThenSuspend = ''
    #!/bin/sh
    hyprlock &
    sleep 1
    systemctl suspend
  '';
in
{
  home.packages = with pkgs; [ swayidle ];

  home.file.".config/hypr/scripts/lock-then-suspend.sh" = {
    text = lockThenSuspend;
    executable = true;
  };

  systemd.user.services.swayidle = {
    Unit = {
      Description = "Idle management daemon";
      PartOf = [ "graphical-session.target" ];
    };

    Service = {
      ExecStart = ''
        ${pkgs.swayidle}/bin/swayidle -w \
          timeout 900 'hyprlock' \
          timeout 1800 '~/.config/hypr/scripts/lock-then-suspend.sh' \
          resume 'hyprctl dispatch dpms on' \
          before-sleep 'hyprlock'
      '';
      Restart = "always";
    };

    Install = {
      WantedBy = [ "graphical-session.target" ];
    };
  };
}

