{ config, pkgs, ... }:
{
  home.packages = with pkgs; [ obsidian ];

  home.file.".config/obsidian/snippets/zoom.css".text = ''
    body {
      zoom: 1.15 !important;
    }
  '';
}
