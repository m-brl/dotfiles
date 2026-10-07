{ inputs, config, pkgs, ... }:

{
  imports = [
    #./librewolf-bookmarks.nix
    ./librewolf/librewolf.nix
    ./firefox.nix
    ./openclaw.nix
    ./element.nix
  ];

  programs = {
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
