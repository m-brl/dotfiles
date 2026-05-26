{ config, pkgs, inputs, ... }:

{
  programs = {
    zsh.enable = true;
    git.enable = true;
    uwsm.enable = true;
    hyprland = {
      enable = true;
      package = pkgs.hyprland;
      portalPackage = pkgs.xdg-desktop-portal-hyprland;
      withUWSM = true;
      xwayland.enable = true;
    };
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
    virt-manager.enable = true;
  };
}
