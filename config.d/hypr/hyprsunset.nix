{ config, pkgs, ... }:

{
  xdg.configFile.hyprsunset = {
    enable = true;
    text = ''
      max-gamma = 150

      profile {
        time = 7:30
        identity = true
      }

      profile {
        time = 21:00
        temperature = 5500
        gamma = 0.8
      }
    '';
    target = "hypr/hyprsunset.conf";
  };

  systemd.user.services.hyprsunset = {
    Unit = {
      Description = "Hyprsunset";
      PartOf = [ "graphical-session.target" ];
      After = [ "graphical-session-pre.target" ];
    };

    Service = {
      ExecStart = "${pkgs.hyprsunset}/bin/hyprsunset";
    };

    Install = {
      WantedBy = [ "hyprland.target" ];
    };
  };
}
