{ inputs, lib, osConfig, pkgs, slib, ... }:

{
  imports = [
    inputs.nix-index-database.homeModules.nix-index
  ];

  programs = {
    nix-index.enable = true;
    nix-index-database.comma.enable = true;

    btop = {
      enable = true;
      package = lib.mkDefault pkgs.btop;
      settings = {
        update_ms = 100;
      };
    };

    gh = {
      enable = true;
      package = slib.wrapSecrets {
        pkg = pkgs.gh;
        secrets.GH_TOKEN = osConfig.sops.secrets."mathieu/GH_TOKEN".path;
      };
    };

    claude-code = {
      enable = true;
      package = slib.wrapSecrets {
        pkg = pkgs.claude-code;
        secrets.CLAUDE_CODE_OAUTH_TOKEN = osConfig.sops.secrets."mathieu/CLAUDE_CODE_OAUTH_TOKEN".path;
      };
    };
  };
}
