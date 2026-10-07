{ inputs, config, pkgs, ... }:

{
  imports = [
    ./librewolf
    ./firefox.nix
    #    ./openclaw.nix
    ./element.nix

    inputs.nix-index-database.homeModules.nix-index
  ];

  programs = {
    nix-index.enable = true;
    nix-index-database.comma.enable = true;

    btop = {
      enable = true;
      package = (pkgs.btop.override { cudaSupport = true; });
      settings = {
        update_ms = 100;
      };
    };

    gh = {
      enable = true;
      gitCredentialHelper = {
        enable = true;
      };
    };

    vscode = {
      enable = true;
    };

    claude-code = {
      enable = true;
    };

    password-store = {
      enable = true;
      package = pkgs.pass-wayland;
    };

    thunderbird = {
      enable = true;
      profiles = {
        mathieu = {
          isDefault = true;
        };
      };
    };

  };
}
