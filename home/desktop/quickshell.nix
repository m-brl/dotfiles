{ config, pkgs, inputs, ... }:

{
  xdg.configFile."quickshell" = {
    source = ./quickshell;
    recursive = true;
  };

  systemd.user.services.quickshell = {
    Unit = {
      Description = "Quickshell";
      After = [ "graphical-session.target" ];
      PartOf = [ "graphical-session.target" ];
    };

    Service = {
      ExecStart = "${pkgs.quickshell}/bin/quickshell";
      Restart = "on-failure";
    };

    Install = {
      WantedBy = [ "graphical-session.target" ];
    };

  };
}
