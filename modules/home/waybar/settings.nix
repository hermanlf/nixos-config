{ host, ... }:
let
  custom = {
    font = "Maple Mono";
    font_size = "18px";
    font_weight = "bold";
    text_color = "#FBF1C7";
    background_0 = "#1D2021";
    background_1 = "#282828";
	background_3 = "#4f4a44";
    border_color = "#928374";
    red = "#CC241D";
    green = "#98971A";
    yellow = "#FABD2F";
    blue = "#458588";
    magenta = "#B16286";
    cyan = "#689D6A";
    orange = "#D65D0E";
    opacity = "1";
    indicator_height = "2px";
  };
in
{
  programs.waybar.settings.mainBar = with custom; {
    position = "top";
    layer = "top";
    height = 28;
    margin-top = 5;
    margin-bottom = 5;
    margin-left = 5;
    margin-right = 5;
    modules-left = [
      "custom/launcher"
      "hyprland/workspaces"
      "hyprland/window"
    ];
    modules-center = [  ];
    modules-right = [
	  "tray"
      "cpu"
      "memory"
      (if (host == "desktop") then "disk" else "")
      "pulseaudio"
      "network"
      "battery"
      "hyprland/language"
	  "clock"
      "custom/notification"
    ];
    clock = {
      calendar = {
        format = {
          today = "<span color='#98971A'><b>{}</b></span>";
        };
      };
      format = "  {:%H:%M}";
      tooltip = "true";
      tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
      format-alt = "  {:%d/%m}";
    };
    "hyprland/workspaces" = {
      active-only = false;
      disable-scroll = true;
      format = "{icon}";
      on-click = "activate";
      format-icons = {
        "1" = "1";
        "2" = "2";
        "3" = "3";
        "4" = "4";
        "5" = "5";
        "6" = "6";
        "7" = "7";
        "8" = "8";
        "9" = "9";
        "10" = "0";
        sort-by-number = true;
      };
      persistent-workspaces = {
        "1" = [ ];
        "2" = [ ];
        "3" = [ ];
        "4" = [ ];
        "5" = [ ];
        "6" = [ ];
        "7" = [ ];
        "8" = [ ];
        "9" = [ ];
        "10" = [ ];		
      };
    };
    "hyprland/window" = {
     format = "{initialClass}";
     rewrite = {
       "" = "x"; # Display a placeholder icon when empty
      };
    };
    cpu = {
      format = "<span foreground='${text_color}'> </span> {usage}%";
      format-alt = "<span foreground='${text_color}'> </span> {avg_frequency} GHz";
      interval = 2;
      on-click-right = "hyprctl dispatch exec '[float; center; size 950 650] kitty --override font_size=14 --title float_kitty btop'";
    };
    memory = {
      format = "<span foreground='${cyan}'>󰟜 </span>{}%";
      format-alt = "<span foreground='${cyan}'>󰟜 </span>{used} GiB"; # 
      interval = 2;
      on-click-right = "hyprctl dispatch exec '[float; center; size 950 650] kitty --override font_size=14 --title float_kitty btop'";
    };
    disk = {
      # path = "/";
      format = "<span foreground='${orange}'>󰋊 </span>{percentage_used}%";
      interval = 60;
      on-click-right = "hyprctl dispatch exec '[float; center; size 950 650] kitty --override font_size=14 --title float_kitty btop'";
    };
    network = {
      format-wifi = "<span foreground='${magenta}'> </span> {signalStrength}%";
      format-ethernet = "<span foreground='${magenta}'>󰀂 </span>";
      tooltip-format = "Connected to {essid} {ifname} via {gwaddr}";
      format-linked = "{ifname} (No IP)";
      format-disconnected = "<span foreground='${magenta}'>󰖪 </span>";
    };
    tray = {
      icon-size = 20;
      spacing = 8;
    };
    pulseaudio = {
      format = "{icon} {volume}%";
      format-muted = "<span foreground='${blue}'> </span> {volume}%";
      format-icons = {
        default = [ "<span foreground='${blue}'> </span>" ];
      };
      scroll-step = 2;
      on-click = "pamixer -t";
      on-click-right = "pavucontrol";
    };
    battery = {
      format = "<span foreground='${yellow}'>{icon}</span> {capacity}%";
      format-icons = [
        " "
        " "
        " "
        " "
        " "
      ];
      format-charging = "<span foreground='${yellow}'> </span>{capacity}%";
      format-full = "<span foreground='${yellow}'> </span>{capacity}%";
      format-warning = "<span foreground='${yellow}'> </span>{capacity}%";
      interval = 5;
      states = {
        warning = 20;
      };
      format-time = "{H}h{M}m";
      tooltip = true;
      tooltip-format = "{time}";
    };
    "hyprland/language" = {
      format = "<span foreground='#FABD2F'> </span> {}";
      format-fr = "FR";
      format-en = "US";
    };
    "custom/launcher" = {
      format = "";
      on-click = "random-wallpaper";
      on-click-right = "rofi -show drun";
      tooltip = "true";
      tooltip-format = "Random Wallpaper";
    };
    "custom/notification" = {
      tooltip = false;
      format = "{icon} ";
      format-icons = {
        notification = "<span foreground='red'><sup></sup></span>  <span foreground='${red}'></span>";
        none = "  <span foreground='${red}'></span>";
        dnd-notification = "<span foreground='red'><sup></sup></span>  <span foreground='${red}'></span>";
        dnd-none = "  <span foreground='${red}'></span>";
        inhibited-notification = "<span foreground='red'><sup></sup></span>  <span foreground='${red}'></span>";
        inhibited-none = "  <span foreground='${red}'></span>";
        dnd-inhibited-notification = "<span foreground='red'><sup></sup></span>  <span foreground='${red}'></span>";
        dnd-inhibited-none = "  <span foreground='${red}'></span>";
      };
      return-type = "json";
      exec-if = "which swaync-client";
      exec = "swaync-client -swb";
      on-click = "swaync-client -t -sw";
      on-click-right = "swaync-client -d -sw";
      escape = true;
    };
  };
}
