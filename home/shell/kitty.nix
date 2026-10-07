{ config, pkgs, ... }:

{
  programs.kitty = {
    enable = true;

    settings = {
      font_family = "family='JetBrainsMono Nerd Font' style='Bold'";

      cursor_trail = 1;
      cursor_trail_decay = "0.1 0.4";
      custom_shaders = "cursor-trail-motion-blur";
      cursor_blink_interval = "0.5 ease-in-out";

    };
  };

  programs.ghostty = {
    enable = true;
  };
}
