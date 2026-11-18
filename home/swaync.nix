{ pkgs, ... }:

{
  services.swaync = {
    enable = true;
    settings = {
      scripts = {
      };
    };
  };
}
