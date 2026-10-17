{ config, pkgs, ... }:

{
  xdg.configFile."quickshell-bar" = {
    source = ./quickshell/bar;
    recursive = true;
  };

  systemd.user.services.quickshell-bar = {
    Unit = {
      Description = "Quickshell";
      After = [ "graphical-session.target" ];
      PartOf = [ "graphical-session.target" ];
    };

    Service = {
      ExecStart = "${pkgs.quickshell}/bin/quickshell -p shell.qml";
      WorkingDirectory = "${config.home.homeDirectory}/.config/quickshell-bar";
      Restart = "on-failure";
    };

    Install = {
      WantedBy = [ "graphical-session.target" ];
    };

  };

}
