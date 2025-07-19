{ config, pkgs, ... }:

{
  systemd.services."fix-mnt-data-perms" = {
    description = "Fix ownership of /mnt/data";
    wantedBy = [ "multi-user.target" ];
    after = [ "local-fs.target" ];
    serviceConfig = {
      Type = "oneshot";
      ExecStart = "${pkgs.coreutils}/bin/chown -R hermanlf:users /mnt/data";
    };
  };
}
