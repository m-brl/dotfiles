{ config, pkgs, ... }:

{
  imports = [
    ./hyprland.nix ./waybar.nix ./swaync.nix
  ];

  services.awww = {
    enable = true;
  };
}
