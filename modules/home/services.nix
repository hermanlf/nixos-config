# modules/home/services.nix
# ═══════════════════════════════════════════════════════════════════════════════
# 🔧 SYSTEMD USER SERVICES CONFIGURATION
# ═══════════════════════════════════════════════════════════════════════════════
# Reliable background services that auto-start and auto-restart:
# • KDE Connect system tray integration
# • Future services can be added here
# ═══════════════════════════════════════════════════════════════════════════════

{ pkgs, ... }:

{
  # ╭─────────────────────────────────────────────────────────────────────────╮
  # │                   📱 KDE CONNECT BACKGROUND DAEMON                     │
  # ╰─────────────────────────────────────────────────────────────────────────╯
  systemd.user.services.kdeconnect-daemon = {
    Unit = {
      Description = "KDE Connect Background Daemon";
      Documentation = "https://kdeconnect.kde.org/";
      After = [ "graphical-session.target" ];
      Wants = [ "graphical-session.target" ];
      PartOf = [ "graphical-session.target" ];
    };
    
    Service = {
      Type = "simple";
      ExecStart = "${pkgs.plasma5Packages.kdeconnect-kde}/bin/kdeconnect-indicator";
      Restart = "on-failure";
      RestartSec = 3;
      
      # Import all session environment variables
      Environment = [
        "XDG_CURRENT_DESKTOP=Hyprland"
        "QT_QPA_PLATFORM=wayland"        # Use wayland instead of offscreen
        "QT_QPA_PLATFORMTHEME=qt5ct"     # Enable qt5ct theming
        "QT_STYLE_OVERRIDE=Breeze"       # Use Breeze style
      ];
      
      # Security settings
      PrivateNetwork = false;  # Needs network for phone connection
      NoNewPrivileges = true;
      ProtectSystem = "strict";
      ProtectHome = false;     # Needs access for file sharing
    };
    
    Install = {
      WantedBy = [ "graphical-session.target" ];
    };
  };

  # ╭─────────────────────────────────────────────────────────────────────────╮
  # │                    🔄 FUTURE SERVICES (EXAMPLES)                       │
  # ╰─────────────────────────────────────────────────────────────────────────╯
  
  # Example: Auto-restart Waybar if it crashes
  # systemd.user.services.waybar-restart = {
  #   Unit = {
  #     Description = "Waybar Auto-Restart Service";
  #     After = [ "graphical-session.target" ];
  #   };
  #   
  #   Service = {
  #     Type = "oneshot";
  #     ExecStart = "${pkgs.procps}/bin/pkill waybar; ${pkgs.waybar}/bin/waybar";
  #     RemainAfterExit = false;
  #   };
  # };

  # Example: Clipboard manager service
  # systemd.user.services.clipboard-manager = {
  #   Unit = {
  #     Description = "Clipboard Manager";
  #     After = [ "graphical-session.target" ];
  #   };
  #   
  #   Service = {
  #     Type = "simple";
  #     ExecStart = "${pkgs.wl-clipboard}/bin/wl-paste --watch ${pkgs.cliphist}/bin/cliphist store";
  #     Restart = "on-failure";
  #   };
  #   
  #   Install = {
  #     WantedBy = [ "graphical-session.target" ];
  #   };
  # };

  # ╭─────────────────────────────────────────────────────────────────────────╮
  # │                       🎯 SERVICE MANAGEMENT                             │
  # ╰─────────────────────────────────────────────────────────────────────────╯
  
  # Useful systemd user service commands:
  # 
  # • Check service status:
  #   systemctl --user status kdeconnect-indicator
  # 
  # • Start/stop manually:
  #   systemctl --user start kdeconnect-indicator
  #   systemctl --user stop kdeconnect-indicator
  # 
  # • View logs:
  #   journalctl --user -u kdeconnect-indicator -f
  # 
  # • Restart service:
  #   systemctl --user restart kdeconnect-indicator
  # 
  # • List all user services:
  #   systemctl --user list-units --type=service
}
