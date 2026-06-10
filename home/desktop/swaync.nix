{ config, pkgs, ... }:

{
  services.swaync = {
    enable = true;
  };

  catppuccin.swaync = {
    enable = false;
  };
}
