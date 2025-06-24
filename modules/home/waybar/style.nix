{ ... }:
let
  custom = {
    font = "Maple Mono";
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

    window#waybar {
      background: transparent;
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
      padding-left: 0px;
    }
    #workspaces button {
	  background: ${background_1};
      color: ${yellow};
      border-radius: 0px;
    }
    #workspaces button.empty {
	  background: ${background_1};
      color: ${text_color};
	  border-radius: 0px;
    }
    #workspaces button.active {
	  background: ${background_3};
      color: ${orange_bright};
	  border-radius: 0px;
    }

    #clock {
	  background: ${green};
      color: ${text_color};
    }

    #tray {
	  background: ${red};
      margin-left: 10px;
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

    #pulseaudio, #network, #cpu, #memory, #disk, #battery, #language, #custom-notification {
      padding-left: 10px;
      padding-right: 10px;
	  margin-right: 10px;
	  color: ${background_1};
    }

    #pulseaudio {
	  background: ${blue};
      margin-left: 10px;
  	}	
	
	#language {
	  background: ${orange};
      margin-left: 10px;
    }

    #network {
	  background: ${blue};
	}
	
	#cpu {
	  background: ${yellow};
	}
	
	#memory {
	  background: ${cyan};
	}
	
	#disk {
	  background: ${orange_bright};
	}
	
	#battery {
	  background: ${cyan};
	}
	
	
    #custom-notification {
	  background: ${red};
      margin-left: 15px;
      padding-right: 2px;
      margin-right: 5px;
    }

    #custom-launcher {
      font-size: 20px;
      color: ${text_color};
      font-weight: bold;
      margin-left: 15px;
      padding-right: 10px;
    }
  '';
}
