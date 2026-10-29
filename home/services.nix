{ config, ... }:

{
  services = {
    protonmail-bridge.enable = true;

    pass-secret-service = {
      enable = true;
      storePath = "${config.home.homeDirectory}/.password-store";
    };

    easyeffects = {
      enable = true;
    };
  };
}
