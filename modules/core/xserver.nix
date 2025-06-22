{ username, ... }:
{
  services = {
    xserver = {
      enable = true;
      xkb.layout = "us";
	  xkb.variant = "";
    };

    displayManager.autoLogin = {
      enable = true;
      user = "${username}";
    };
    libinput = {
      enable = true;
    };
  };
  # To prevent getting stuck at shutdown
  systemd.extraConfig = "DefaultTimeoutStopSec=10s";
}
