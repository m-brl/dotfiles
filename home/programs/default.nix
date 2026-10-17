{ inputs, config, osConfig, pkgs, slib, ... }:

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
      package = slib.wrapSecrets {
        pkg = pkgs.gh;
        secrets.GH_TOKEN = osConfig.sops.secrets."GH_TOKEN".path;
      };
    };

    vscode = {
      enable = true;
    };

    claude-code = {
      enable = true;
      package = slib.wrapSecrets {
        pkg = pkgs.claude-code;
        secrets.CLAUDE_CODE_OAUTH_TOKEN = osConfig.sops.secrets."CLAUDE_CODE_OAUTH_TOKEN".path;
      };
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
