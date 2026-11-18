{ inputs, osConfig, pkgs, slib, ... }:

{
  imports = [
    inputs.nix-index-database.homeModules.nix-index
  ];

  programs = {
    nix-index.enable = true;
    nix-index-database.comma.enable = true;

    btop = {
      enable = true;
      package = pkgs.btop.override { cudaSupport = true; };
      settings = {
        update_ms = 100;
        shown_boxes = "cpu mem net proc gpu0 gpu1";
      };
    };

    gh = {
      enable = true;
      package = slib.wrapSecrets {
        pkg = pkgs.gh;
        secrets.GH_TOKEN = osConfig.sops.secrets."mathieu/GH_TOKEN".path;
      };
    };

    password-store = {
      enable = true;
      package = pkgs.pass-wayland.withExtensions (exts: [ exts.pass-otp ]);
    };
  };

  home.packages = [ pkgs.fuse3 ];
}
