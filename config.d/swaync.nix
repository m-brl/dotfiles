{ config, pkgs, ... }:

{
  home.packages = [
    pkgs.swaynotificationcenter
  ];

  systemd.user.services.swaync = {
    Unit = {
      Description = "Sway Notification Center";
      PartOf = [ "graphical-session.target" ];
      After = [ "graphical-session-pre.target" ];
    };

    Service = {
      ExecStart = "${pkgs.swaynotificationcenter}/bin/swaync";
      Restart = "on-failure";
    };

    Install = {
      WantedBy = [ "hyprland.target" ];
    };
  };
}
