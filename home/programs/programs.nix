{ config, pkgs, ... }:

{
  imports = [
    ./librewolf-bookmarks.nix
    ./element.nix
  ];

  programs.kitty.enable = true;

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
