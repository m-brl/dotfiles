{ lib, pkgs, ... }:

let
  sddmTheme = pkgs.stdenv.mkDerivation {
    name = "custom-theme";
    src = lib.cleanSourceWith {
      src = ./sddm-theme;
      filter = path: type: !(builtins.elem (baseNameOf path) [ "flake.nix" "flake.lock" ]);
    };
    installPhase = ''
      mkdir -p $out/share/sddm/themes/custom-theme
      cp -r * $out/share/sddm/themes/custom-theme
    '';
  };
in
{
  programs = {
    dconf.enable = true;

    uwsm.enable = true;
    hyprland = {
      enable = true;
      package = pkgs.hyprland;
      portalPackage = pkgs.xdg-desktop-portal-hyprland;
      withUWSM = true;
      xwayland.enable = true;
    };
    hyprlock.enable = true;
  };

  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
    package = pkgs.kdePackages.sddm;
    extraPackages = [ pkgs.adwaita-icon-theme ];

    settings = {
      Theme = {
        CursorTheme = "Adwaita";
      };
    };
  };

  environment.systemPackages = [ sddmTheme ];

  security.rtkit.enable = true;

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };
}
