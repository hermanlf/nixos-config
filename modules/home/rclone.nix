{ config, lib, pkgs, ... }:

let
  mountPoint = "${config.home.homeDirectory}/Proton";
in
{
  options.home.rclone.enable = lib.mkEnableOption "Enable rclone mount of Proton Drive";

  config = lib.mkIf config.home.rclone.enable {
    home.packages = [ pkgs.rclone ];

    # Ensure the mount point exists
    home.file."Proton" = {
      directory = true;
      recursive = true;
    };

    # Systemd user service to mount Proton Drive
    systemd.user.services.rclone-proton = {
      Unit = {
        Description = "Mount Proton Drive using rclone";
        After = [ "network-online.target" ];
      };

      Service = {
        ExecStart = ''
          ${pkgs.rclone}/bin/rclone mount proton: ${mountPoint} \
            --vfs-cache-mode writes \
            --allow-other \
            --umask 002 \
            --uid $(id -u) \
            --gid $(id -g)
        '';
        ExecStop = "fusermount -u ${mountPoint}";
        Restart = "on-failure";
      };

      Install = {
        WantedBy = [ "default.target" ];
      };
    };
  };
}
