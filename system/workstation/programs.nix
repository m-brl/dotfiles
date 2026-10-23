{ pkgs, ... }:

{
  programs = {
    dconf.enable = true;
    yubikey-manager.enable = true;

    uwsm.enable = true;
    hyprland = {
      enable = true;
      package = pkgs.hyprland;
      portalPackage = pkgs.xdg-desktop-portal-hyprland;
      withUWSM = true;
      xwayland.enable = true;
    };
    hyprlock.enable = true;

    virt-manager.enable = true;
  };
}
