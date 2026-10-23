{ pkgs, ... }:

{
  imports = [
    ./librewolf
#    ./openclaw.nix
    ./element.nix
    ./newsboat.nix
  ];

  programs = {
    btop.package = pkgs.btop.override { cudaSupport = true; };

    vscode = {
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
