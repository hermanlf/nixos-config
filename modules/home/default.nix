{ ... }:
{
  imports = [
    ./aseprite/aseprite.nix           # pixel art editor
    ./audacious.nix                   # music player
    ./bat.nix                         # better cat command
    ./browser.nix                     # firefox based browser
    ./btop.nix                        # resouces monitor 
    ./cava.nix                        # audio visualizer
    ./discord.nix                     # discord
    ./fastfetch.nix                   # fetch tool
    ./flow.nix                        # terminal text editor
    ./foot.nix                        # foot terminal with gruvbox theme
    ./fzf.nix                         # fuzzy finder
    ./gaming.nix                      # packages related to gaming
    ./ghostty.nix                     # terminal
    ./git.nix                         # version control
    ./gnome.nix                       # gnome apps
    ./gtk.nix                         # gtk theme
    ./hyprland                        # window manager
    ./keeper.nix                      # keeper password manager
    ./kitty.nix                       # terminal
    ./lazygit.nix
    ./ledger-live.nix                 # Ledge Live cryptocurrency wallet
    ./micro.nix                       # nano replacement
    ./nemo.nix                        # file manager
    ./neovim.nix                      # neovim editor
    ./nix-search/nix-search.nix       # TUI to search nixpkgs
    ./obsidian.nix
    ./p10k/p10k.nix
    ./packages                        # other packages
    ./qt-theme.nix
    ./retroarch.nix  
    ./rofi.nix                        # launcher
    ./scripts/scripts.nix             # personal scripts
    ./services.nix                    # systemd user services (KDE COnnect)
    ./ssh.nix                         # ssh config
    ./superfile/superfile.nix         # terminal file manager
    ./swaylock.nix                    # lock screen
    ./swayosd.nix                     # brightness / volume wiget
    ./swaync/swaync.nix               # notification deamon
    # ./viewnior.nix                    # image viewer
    ./vscodium                        # vscode fork
    ./waybar                          # status bar
    ./waypaper.nix                    # GUI wallpaper picker
    ./xdg-mimes.nix                   # xdg config
    ./zsh                             # shell
  ];

}
