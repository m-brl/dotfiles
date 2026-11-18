{ config, lib, pkgs, ... }:

{
  services.protonmail-bridge.enable = true;

  services.pass-secret-service = {
    enable = true;
    storePath = "${config.home.homeDirectory}/.password-store";
  };

  services.easyeffects = {
    enable = true;
  };

  systemd.user.services.logid = {
    Unit = {
      Description = "Logid";
      After = [ "graphical-session.target" ];
      Wants = [ "graphical-session.target" ];
    };

    Service = {
      Type = "simple";
      ExecStart = "${lib.getExe pkgs.logid}";
      Restart = "on-failure";
      RestartSec = 1;
      TimeoutStopSec = 10;
    };

    Install.WantedBy = [ "graphical-session.target" ];
  };

  systemd.user.services.sonyd = {
    Unit = {
      Description = "Sonyd";
      After = [ "graphical-session.target" ];
      Wants = [ "graphical-session.target" ];
    };

    Service = {
      Type = "simple";
      ExecStart = "${lib.getExe pkgs.sonyd} 58:18:62:17:D8:FE";
      Restart = "on-failure";
      RestartSec = 1;
      TimeoutStopSec = 10;
    };

    Install.WantedBy = [ "graphical-session.target" ];
  };

  home.packages = with pkgs; [
    logid sonyd
  ];
}
