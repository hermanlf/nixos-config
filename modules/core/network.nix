{ pkgs, host, ... }:
{
  networking = {
    hostName = "${host}";
    networkmanager.enable = true;
    nameservers = [
      "8.8.8.8"
      "8.8.4.4"
      "1.1.1.1"
    ];
    firewall = {
      enable = true;
      allowedTCPPorts = [
        22
        80
        443
        59010
        59011
        # Add KDE Connect ports
      ] ++ (builtins.genList (x: x + 1714) 51);  # Ports 1714-1764
      allowedUDPPorts = [
        59010
        59011
        # Add KDE Connect ports 
      ] ++ (builtins.genList (x: x + 1714) 51);  # Ports 1714-1764
    };
  };

  environment.systemPackages = with pkgs; [ networkmanagerapplet ];
}
