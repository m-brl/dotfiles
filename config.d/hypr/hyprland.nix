{ config, pkgs, ... }:

{
  systemd.user.targets.hyprland = {
    Unit = {
      Description = "Hyprland target";
    };
  };
}
