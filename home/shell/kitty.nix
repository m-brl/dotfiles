{ config, pkgs, ... }:

{
  programs.kitty = {
    enable = true;

    settings = {
      background_opacity = 0.9;
    };

    font = {
      name = "JetBrainsMono Nerd Font";
      size = 11;
    };
  };
}
