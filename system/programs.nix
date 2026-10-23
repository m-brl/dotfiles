{ config, pkgs, inputs, ... }:

{
  programs = {
    nix-ld.enable = true;
    dconf.enable = true;
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

    virt-manager.enable = true;

    nh = {
      enable = true;

      flake = "/etc/nixos";

      clean = {
        enable = true;
        dates = "weekly";
        extraArgs = "--keep-since 7d --keep 5";
      };
    };
  };
}
