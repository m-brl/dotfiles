{ config, pkgs, ... }:

{
  home.packages = [
    pkgs.swayosd
  ];

  #xdg.configFile.swayosd = {
  #  enable = true;
  #  source = ./swayosd.conf;
  #  target = "";
  #};

  systemd.user.services.swayosd = {
    Unit = {
      Description = "Sway OSD";
      PartOf = [ "graphical-session.target" ];
      After = [ "graphical-session-pre.target" ];
    };

    Service = {
      ExecStart = "${pkgs.swayosd}/bin/swayosd-server";
      Restart = "on-failure";
    };

    Install = {
      WantedBy = [ "hyprland.target" ];
    };
  };
}
