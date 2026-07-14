{ config, pkgs, ... }:

{
  imports = [
    ./librewolf-bookmarks.nix
    ./element.nix
  ];

  programs.kitty = {
    enable = true;
    autoThemeFiles = {
      light = "Catppuccin-Latte";
      dark = "Catppuccin-Mocha";
      noPreference = "Catppuccin-Mocha";
    };
  };

  programs.password-store = {
    enable = true;
    package = pkgs.pass-wayland;
  };

  programs.thunderbird = {
    enable = true;
    profiles = {
      mathieu = {
        isDefault = true;
      };
    };
  };
}
