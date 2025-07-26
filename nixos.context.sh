#!/usr/bin/env zsh
# echo -e "\n" >> nixos.structure.txt
OUTPUT_FILE="$HOME/structure.txt"
REPO_DIR="/mnt/data/repo/nixos-config"

cd /mnt/data/repo
echo "--- BEGIN My modular NixOS configuration structure ---" > "$OUTPUT_FILE"
eza --icons --tree --group-directories-first -I '.git|.github|.gitignore' nixos-config >> "$OUTPUT_FILE"
echo "--- END My modular NixOS configuration structure ---" >> "$OUTPUT_FILE"

echo -e "\n" >> "$OUTPUT_FILE"
echo "--- BEGIN nixos-config/flake.nix ---" >> "$OUTPUT_FILE"
bat --style=plain "$REPO_DIR/flake.nix" >> "$OUTPUT_FILE" 
echo "--- END nixos-config/flake.nix" >> "$OUTPUT_FILE"

echo -e "\n" >> "$OUTPUT_FILE"
echo "--- BEGIN nixos-config/hosts/desktop/default.nix ---" >> "$OUTPUT_FILE"
bat --style=plain "$REPO_DIR/hosts/desktop/default.nix" >> "$OUTPUT_FILE"
echo "--- END nixos-config/hosts/desktop/default.nix ---" >> "$OUTPUT_FILE"

echo -e "\n" >> "$OUTPUT_FILE"
echo "--- BEGIN nixos-config/hosts/desktop/hardware-configuration.nix ---" >> "$OUTPUT_FILE"
bat --style=plain "$REPO_DIR/hosts/desktop/hardware-configuration.nix" >> "$OUTPUT_FILE"
echo "--- END nixos-config/hosts/desktop/hardware-configuration.nix ---" >> "$OUTPUT_FILE"

echo -e "\n" >> "$OUTPUT_FILE"
echo "--- BEGIN nixos-config/modules/core/default.nix ---" >> "$OUTPUT_FILE"
bat --style=plain "$REPO_DIR/modules/core/default.nix" >> "$OUTPUT_FILE"
echo "--- END nixos-config/modules/core/default.nix ---" >> "$OUTPUT_FILE"

echo -e "\n" >> "$OUTPUT_FILE"
echo "--- BEGIN nixos-config/modules/core/user.nix ---" >> "$OUTPUT_FILE"
bat --style=plain "$REPO_DIR/modules/core/user.nix" >> "$OUTPUT_FILE"
echo "--- END nixos-config/modules/core/user.nix ---" >> "$OUTPUT_FILE"

echo -e "\n" >> "$OUTPUT_FILE"
echo "--- BEGIN nixos-config/modules/home/default.nix ---" >> "$OUTPUT_FILE"
bat --style=plain "$REPO_DIR/modules/home/default.nix" >> "$OUTPUT_FILE"
echo "--- END nixos-config/modules/home/default.nix ---" >> "$OUTPUT_FILE"

echo -e "\n" >> "$OUTPUT_FILE"
echo "--- BEGIN nixos-config/modules/home/gnome.nix ---" >> "$OUTPUT_FILE"
bat --style=plain "$REPO_DIR/modules/home/gnome.nix" >> "$OUTPUT_FILE"
echo "--- END nixos-config/modules/home/gnome.nix ---" >> "$OUTPUT_FILE"

echo -e "\n" >> "$OUTPUT_FILE"
echo "--- BEGIN nixos-config/modules/home/hyprland/default.nix ---" >> "$OUTPUT_FILE"
bat --style=plain "$REPO_DIR/modules/home/hyprland/default.nix" >> "$OUTPUT_FILE"
echo "--- END nixos-config/modules/home/hyprland/default.nix ---" >> "$OUTPUT_FILE"

echo -e "\n" >> "$OUTPUT_FILE"
echo "--- BEGIN nixos-config/modules/home/hyprland/config.nix ---" >> "$OUTPUT_FILE"
bat --style=plain "$REPO_DIR/modules/home/hyprland/config.nix" >> "$OUTPUT_FILE"
echo "--- END nixos-config/modules/home/hyprland/config.nix ---" >> "$OUTPUT_FILE"

echo -e "\n" >> "$OUTPUT_FILE"
echo "--- BEGIN nixos-config/modules/home/waybar/default.nix ---" >> "$OUTPUT_FILE"
bat --style=plain "$REPO_DIR/modules/home/waybar/default.nix" >> "$OUTPUT_FILE"
echo "--- END nixos-config/modules/home/waybar/default.nix ---" >> "$OUTPUT_FILE"

echo -e "\n" >> "$OUTPUT_FILE"
echo "--- BEGIN nixos-config/modules/home/waybar/settings.nix ---" >> "$OUTPUT_FILE"
bat --style=plain "$REPO_DIR/modules/home/waybar/settings.nix" >> "$OUTPUT_FILE"
echo "--- END nixos-config/modules/home/waybar/settings.nix ---" >> "$OUTPUT_FILE"

echo -e "\n" >> "$OUTPUT_FILE"
