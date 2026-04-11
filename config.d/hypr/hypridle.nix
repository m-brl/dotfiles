{ config, pkgs, ... }:

{
  xdg.configFile.hypridle = {
    enable = true;
    source = ./hypridle.conf;
    target = "hypr/hypridle.conf";
  };

  systemd.user.services.hypridle = {
    Unit = {
      Description = "Hypridle";
      PartOf = [ "graphical-session.target" ];
      After = [ "graphical-session-pre.target" ];
    };

    Service = {
      ExecStart = "${pkgs.hypridle}/bin/hypridle";
    };

    Install = {
      WantedBy = [ "hyprland.target" ];
    };
  };
}
