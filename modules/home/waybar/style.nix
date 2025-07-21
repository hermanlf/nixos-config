{ ... }:
let
  custom = {
    font = "CaskaydiaCove Nerd Font Propo";
    font_size = "18px";
    font_weight = "bold";
    text_color = "#FBF1C7";
    background_0 = "#1D2021";
    background_1 = "#282828";
    background_3 = "#4f4a44";
    border_color = "#A89984";
    red = "#CC241D";
    green = "#98971A";
    yellow = "#FABD2F";
    blue = "#458588";
    magenta = "#B16286";
    cyan = "#689D6A";
    orange = "#D65D0E";
    orange_bright = "#FE8019";
    opacity = "1";
    indicator_height = "2px";
  };
in
{
  programs.waybar.style = with custom; ''
    * {
      border: none;
      border-radius: 0px;
      padding: 0;
      margin: 0;
      font-family: ${font};
      font-weight: ${font_weight};
      opacity: ${opacity};
      font-size: ${font_size};
    }

    .modules-left {
      background-color: rgba(46, 52, 64, 0);
      padding: 0px 15px;
      border-radius: 20px 20px 20px 20px;
    }

    .modules-center {
      background-color: rgba(76, 86, 106, 0);
      padding: 0 20px;
      font-weight: bold;
      border-radius: 20px 20px 20px 20px;
      /* border-left: 2px solid #434c5e; */
      /* border-right: 2px solid #434c5e; */
    }

    .modules-right {
      background-color: rgba(46, 52, 64, 0);
      padding: 0 15px;
      border-radius: 20px 20px 20px 20px;
    }

    window#waybar {
      background: rgba(0, 0, 0, 0);
      /* border-bottom: 2px solid ${border_color}; */
      /* border-top: 2px solid ${border_color}; */
      /* border-left: 2px solid ${border_color}; */
      /* border-right: 2px solid ${border_color}; */
    }

    tooltip {
      background: ${background_1};
      border: 1px solid ${border_color};
    }
    tooltip label {
      margin: 5px;
      color: ${text_color};
    }

    #workspaces {
      /* padding-left: 15px; */
      /* border-bottom: 1px solid ${border_color}; */
      /* border-top: 1px solid ${border_color}; */
    }
    #workspaces button {
	/* background: ${background_1}; */
      background: rgba(0, 0, 0, 0.2);
      color: ${yellow};
      border-radius: 0px;
    }
    #workspaces button.empty {
	/* background: ${background_1}; */
      background: rgba(0, 0, 0, 0.2);
      color: ${text_color};
	  border-radius: 0px;
    }
    #workspaces button.active {
	/* background: ${background_3}; */
      background: rgba(0, 0, 0, 0.2);
      color: ${orange_bright};
	  border-radius: 0px;
    }

    #clock {
      color: ${text_color};
    }

    #tray {
      margin-left: 20px;
      margin-right: 10px;
      color: ${text_color};
    }
    #tray menu {
      background: ${background_1};
      border: 1px solid ${border_color};
      padding: 8px;
    }
    #tray menuitem {
      padding: 1px;
    }

    #window {
      padding-left: 14px;
    }

    #pulseaudio, #network, #cpu, #memory, #disk, #battery, #language, #custom-notification {
      padding-left: 5px;
      padding-right: 5px;
      margin-right: 10px;
      color: ${text_color};
    }

    #pulseaudio {
      margin-left: 0px;
  	}	
	
	#language {
      margin-left: 0px;
    }
	
    #custom-notification {
      margin-left: 5px;
      padding-right: 0px; /* 2px default */
      margin-right: 3px; /* 5px default */
    }

    #custom-launcher {
      font-size: 20px;
      color: ${text_color};
      font-weight: bold;
      margin-left: 6px;
      margin-right: 15px;
      /* padding-right: 10px; */
    }

    #custom-bluetooth {
      color: ${blue};
    }

    #idle_inhibitor {
      color: ${text_color};
    } 
  '';
}

