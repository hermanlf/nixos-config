# nixos-config/modules/home/foot.nix
{ pkgs, ... }:
{
  programs.foot = {
    enable = true;
    
    settings = {
      main = {
        # Font configuration
        font = "Maple Mono:size=14";
        font-bold = "Maple Mono:weight=bold:size=14";
        font-italic = "Maple Mono:style=italic:size=14";
        font-bold-italic = "Maple Mono:weight=bold:style=italic:size=14";
        
        # Terminal settings
        term = "xterm-256color";
        login-shell = "yes";
        
        # Window settings
        app-id = "foot";
        title = "foot";
        locked-title = "no";
        
        # Padding
        pad = "8x8";
        
        # Selection
        selection-target = "clipboard";
      };

      bell = {
        urgent = "no";
        notify = "no";
        visual = "no";
      };

      scrollback = {
        lines = 10000;
        multiplier = 3.0;
      };

      url = {
        launch = "xdg-open \${url}";
        label-letters = "sadfjklewcmpgh";
        osc8-underline = "url-mode";
      };

      cursor = {
        style = "block";
        color = "282828 ebdbb2";
        blink = "no";
        beam-thickness = "1.5";
        underline-thickness = "1.0";
      };

      mouse = {
        hide-when-typing = "yes";
        alternate-scroll-mode = "yes";
      };

      # Gruvbox Dark color scheme with transparency
      colors = {
        # Background and foreground (with alpha for transparency)
        background = "1d2021";
        foreground = "ebdbb2";
        
        # Background alpha (transparency) - separate setting
        alpha = "0.8";  # 80% opacity (0.0 = fully transparent, 1.0 = fully opaque)
        
        # Selection colors
        selection-foreground = "1d2021";
        selection-background = "ebdbb2";
        
        # URL colors
        urls = "83a598";
        
        # Regular colors (0-7)
        regular0 = "282828";  # black
        regular1 = "cc241d";  # red
        regular2 = "98971a";  # green
        regular3 = "d79921";  # yellow
        regular4 = "458588";  # blue
        regular5 = "b16286";  # magenta
        regular6 = "689d6a";  # cyan
        regular7 = "a89984";  # white
        
        # Bright colors (8-15)
        bright0 = "928374";   # bright black
        bright1 = "fb4934";   # bright red
        bright2 = "b8bb26";   # bright green
        bright3 = "fabd2f";   # bright yellow
        bright4 = "83a598";   # bright blue
        bright5 = "d3869b";   # bright magenta
        bright6 = "8ec07c";   # bright cyan
        bright7 = "ebdbb2";   # bright white
        
        # Dim colors (optional, for when dim attribute is used)
        dim0 = "1d2021";
        dim1 = "9d0006";
        dim2 = "79740e";
        dim3 = "b57614";
        dim4 = "076678";
        dim5 = "8f3f71";
        dim6 = "427b58";
        dim7 = "928374";
      };

      key-bindings = {
        # Clipboard
        clipboard-copy = "Control+Shift+c XF86Copy";
        clipboard-paste = "Control+Shift+v XF86Paste";
        primary-paste = "Shift+Insert";
        
        # Font size
        font-increase = "Control+plus Control+equal Control+KP_Add";
        font-decrease = "Control+minus Control+KP_Subtract";
        font-reset = "Control+0 Control+KP_0";
        
        # Scrollback
        scrollback-up-page = "Shift+Page_Up";
        scrollback-up-half-page = "Control+Shift+Page_Up";
        scrollback-up-line = "Control+Shift+Up";
        scrollback-down-page = "Shift+Page_Down";
        scrollback-down-half-page = "Control+Shift+Page_Down";
        scrollback-down-line = "Control+Shift+Down";
        scrollback-home = "Control+Shift+Home";
        scrollback-end = "Control+Shift+End";
        
        # Search
        search-start = "Control+Shift+r";
        
        # URL mode
        show-urls-launch = "Control+Shift+u";
        show-urls-copy = "Control+Shift+o";
        
        # Misc
        unicode-input = "Control+Shift+i";
        noop = "none";
      };

      search-bindings = {
        cancel = "Control+g Control+c Escape";
        commit = "Return";
        find-prev = "Control+r";
        find-next = "Control+s";
        cursor-left = "Left Control+b";
        cursor-left-word = "Control+Left Mod1+b";
        cursor-right = "Right Control+f";
        cursor-right-word = "Control+Right Mod1+f";
        cursor-home = "Home Control+a";
        cursor-end = "End Control+e";
        delete-prev = "BackSpace";
        delete-prev-word = "Mod1+BackSpace Control+BackSpace";
        delete-next = "Delete";
        delete-next-word = "Mod1+d Control+Delete";
        extend-to-word-boundary = "Control+w";
        extend-to-next-whitespace = "Control+Shift+w";
        clipboard-paste = "Control+v Control+Shift+v Control+y XF86Paste";
        primary-paste = "Shift+Insert";
      };

      url-bindings = {
        cancel = "Control+g Control+c Control+d Escape";
        toggle-url-visible = "t";
      };
    };
  };
}
