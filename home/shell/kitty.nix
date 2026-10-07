{ config, pkgs, ... }:

{
  programs.kitty = {
    enable = true;

    settings = {
      background_opacity = 0.9;

      font_family = "family='JetBrainsMono Nerd Font' style='Bold'";
    };

    font = {
      name = "JetBrainsMono Nerd Font";
      size = 11;
    };
  };
}
