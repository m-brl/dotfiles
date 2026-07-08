{ config, pkgs, ... }:

{
  services = {
    pass-secret-service = {
      enable = true;
      storePath = "${config.home.homeDirectory}/.password-store";
    };
  };
}
