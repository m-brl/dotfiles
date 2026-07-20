{ config, pkgs, inputs, ... }:

{
  programs = {
    yubikey-manager.enable = true;
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
    hyprlock.enable = true;
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
      pinentryPackage = pkgs.pinentry-qt;
    };
    virt-manager.enable = true;
  };
}
