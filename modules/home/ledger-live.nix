# nixos-config/modules/home/ledger-live.nix
{ pkgs, ... }:
{
  # Install Ledger Live desktop application
  home.packages = with pkgs; [
    ledger-live-desktop
  ];

  # XDG desktop entry (if needed for proper integration)
  #xdg.desktopEntries.ledger-live = {
  #  name = "Ledger Live";
  #  comment = "Ledger Live cryptocurrency wallet";
  #  exec = "ledger-live-desktop";
  #  icon = "ledger-live";
  #  categories = [ "Office" "Finance" ];
  #  mimeType = [ "x-scheme-handler/ledgerlive" ];
  #  settings = {
  #    Keywords = "ledger;crypto;cryptocurrency;bitcoin;ethereum;wallet;hardware";
  #  };
  #};

  # Optional: Set up browser integration for Ledger Live web apps
  xdg.mimeApps.defaultApplications = {
    "x-scheme-handler/ledgerlive" = "ledger-live.desktop";
  };
}
