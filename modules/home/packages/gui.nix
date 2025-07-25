{ pkgs, ... }:
{
  home.packages = with pkgs; [
    ## Multimedia
    audacity
    gimp
    obs-studio
    pavucontrol
    soundwireserver
    video-trimmer
    vlc

    ## Office
    libreoffice
    gnome-calculator

    ## Utility
    dconf-editor
    gnome-disk-utility
    mission-center # GUI resources monitor
    zenity

    ## Level editor
    ldtk
    tiled

    ## For kdeconnect-app
    plasma5Packages.kdeconnect-kde
    libsForQt5.qtbase              # Qt5 base (essential)
    libsForQt5.kio                 # File operations support

    ##  Qt theming packages
    libsForQt5.qtstyleplugins       # Qt5 style plugins
    libsForQt5.qt5ct                # Qt5 configuration tool
    qt6Packages.qt6ct               # Qt6 configuration tool (future-proofing)
    
    # Gruvbox-compatible Qt themes
    libsForQt5.breeze-qt5           # KDE Breeze theme (customizable)
    # OR try these alternatives:
    # adwaita-qt                    # GTK-like theme for Qt
    # libsForQt5.qqc2-breeze-style  # Breeze QML style
  ];
}
