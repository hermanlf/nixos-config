# modules/home/qt-theme.nix
# ═══════════════════════════════════════════════════════════════════════════════
# 🎨 QT THEMING FOR GRUVBOX HYPRLAND
# ═══════════════════════════════════════════════════════════════════════════════
# Complete Qt theming setup to make Qt applications (like KDE Connect)
# match your Gruvbox Hyprland theme with dark colors and consistent styling
# ═══════════════════════════════════════════════════════════════════════════════

{ pkgs, ... }:

{
  # ╭─────────────────────────────────────────────────────────────────────────╮
  # │                      📦 QT THEMING PACKAGES                            │
  # ╰─────────────────────────────────────────────────────────────────────────╯
  home.packages = with pkgs; [
    # Qt theming tools
    libsForQt5.qt5ct                # Qt5 Configuration Tool
    libsForQt5.qtstyleplugins       # Additional Qt5 styles
    libsForQt5.breeze-qt5           # KDE Breeze theme for Qt5
    
    # Icon theme for Qt applications (removed to avoid collision)
    # papirus-icon-theme            # Use existing one from your system
    
    # Font packages (if not already installed)
    inter                           # Modern UI font
    dejavu_fonts                    # Monospace font
  ];

  # ╭─────────────────────────────────────────────────────────────────────────╮
  # │                    🎨 QT5CT CONFIGURATION FILE                         │
  # ╰─────────────────────────────────────────────────────────────────────────╯
  xdg.configFile."qt5ct/qt5ct.conf".text = ''
    [Appearance]
    color_scheme_path=${pkgs.writeText "gruvbox-qt.colors" ''
      [ColorScheme]
      active_colors=#fbf1c7, #3c3836, #504945, #665c54, #282828, #1d2021, #fbf1c7, #fbf1c7, #fbf1c7, #1d2021, #1d2021, #a89984, #458588, #fbf1c7, #83a598, #d3869b, #1d2021, #fbf1c7, #1d2021, #fbf1c7, #1d2021
      disabled_colors=#928374, #3c3836, #504945, #665c54, #282828, #1d2021, #928374, #928374, #928374, #1d2021, #1d2021, #a89984, #458588, #928374, #83a598, #d3869b, #1d2021, #928374, #1d2021, #928374, #1d2021
      inactive_colors=#ebdbb2, #3c3836, #504945, #665c54, #282828, #1d2021, #ebdbb2, #ebdbb2, #ebdbb2, #1d2021, #1d2021, #a89984, #458588, #ebdbb2, #83a598, #d3869b, #1d2021, #ebdbb2, #1d2021, #ebdbb2, #1d2021
    ''}
    custom_palette=true
    icon_theme=Papirus-Dark
    standard_dialogs=default
    style=Breeze

    [Fonts]
    fixed="DejaVu Sans Mono,10,-1,5,50,0,0,0,0,0"
    general="Inter,10,-1,5,50,0,0,0,0,0"

    [Interface]
    activate_item_on_single_click=1
    buttonbox_layout=0
    cursor_flash_time=1000
    dialog_buttons_have_icons=1
    double_click_interval=400
    gui_effects=@Invalid()
    keyboard_scheme=2
    menus_have_icons=true
    show_shortcuts_in_context_menus=true
    stylesheets=@Invalid()
    toolbutton_style=4
    underline_shortcut=1
    wheel_scroll_lines=3

    [SettingsWindow]
    geometry=""
  '';

  # ╭─────────────────────────────────────────────────────────────────────────╮
  # │                       🔧 QT ENVIRONMENT VARIABLES                      │
  # ╰─────────────────────────────────────────────────────────────────────────╯
  # These should be added to your variables.nix file:
  #
  # home.sessionVariables = {
  #   QT_QPA_PLATFORMTHEME = "qt5ct";        # Use qt5ct for Qt theming
  #   QT_STYLE_OVERRIDE = "Breeze";          # Use Breeze style as base
  # };

  # ╭─────────────────────────────────────────────────────────────────────────╮
  # │                     📝 GRUVBOX COLOR REFERENCE                         │
  # ╰─────────────────────────────────────────────────────────────────────────╯
  # Colors used in the theme (for reference):
  #
  # Gruvbox Dark Colors:
  # #1d2021 - dark0_hard (darkest background)
  # #282828 - dark0 (main background)  
  # #3c3836 - dark1 (slightly lighter background)
  # #504945 - dark2 (button backgrounds)
  # #665c54 - dark3 (borders)
  # #928374 - gray (disabled text)
  #
  # Gruvbox Light Colors:
  # #fbf1c7 - light0_hard (brightest text)
  # #ebdbb2 - light1 (main text)
  # #a89984 - light4 (dimmer text)
  #
  # Gruvbox Accent Colors:
  # #458588 - blue (highlights, selection)
  # #83a598 - light blue (links)
  # #d3869b - purple (visited links)

  # ╭─────────────────────────────────────────────────────────────────────────╮
  # │                        🎯 USAGE INSTRUCTIONS                           │
  # ╰─────────────────────────────────────────────────────────────────────────╯
  #
  # 1. Add this file to your imports in modules/home/default.nix:
  #    ./qt-theme.nix
  #
  # 2. Add these to your modules/home/hyprland/variables.nix:
  #    QT_QPA_PLATFORMTHEME = "qt5ct";
  #    QT_STYLE_OVERRIDE = "Breeze";
  #
  # 3. Rebuild your system:
  #    sudo nixos-rebuild switch --flake .#desktop
  #
  # 4. Test with KDE Connect:
  #    kdeconnect-app
  #
  # 5. Fine-tune if needed:
  #    qt5ct (opens configuration GUI)
}
