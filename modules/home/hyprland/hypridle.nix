{ config, pkgs, ... }:

{
  # Create lock-then-suspend script declaratively
  home.file.".config/hypr/scripts/lock-then-suspend.sh" = {
    text = ''
      #!/bin/sh
      hyprlock &
      sleep 1
      systemctl suspend
    '';
    executable = true;
  };

  # Hypridle configuration
  services.hypridle = {
    enable = true;
    settings = {
      general = {
        lock_cmd = "pidof hyprlock || hyprlock";
        before_sleep_cmd = "loginctl lock-session";
      };

      listener = [
        {
          timeout = 500;
          on-timeout = "loginctl lock-session";
        }
        {
          timeout = 560;
          on-timeout = "hyprctl dispatch dpms off";
          on-resume = "hyprctl dispatch dpms on";
        }
        {
          timeout = 1800;
          on-timeout = "${config.home.homeDirectory}/.config/hypr/scripts/lock-then-suspend.sh";
        }
      ];
    };
  };

  # Ensure hypridle service is started after login
  systemd.user.services.hypridle = {
    Install = {
      WantedBy = [ "graphical-session.target" ];
    };
  };
}
