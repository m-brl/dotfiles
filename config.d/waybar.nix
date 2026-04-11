{ config, pkgs, ... }:

{
  xdg.configFile.waybar = {
    enable = true;
    source = ./waybar;
    recursive = true;
  };
  
  systemd.user.services.waybar = {
    Unit = {
      Description = "Waybar status bar";
      PartOf = [ "graphical-session.target" ];
      After = [ "graphical-session-pre.target" ];
    };

    Service = {
      ExecStart = "${pkgs.waybar}/bin/waybar";
      Restart = "on-failure";
    };

    Install = {
      WantedBy = [ "hyprland.target" ];
    };
  };



  systemd.user.services.eww = {
    Unit = {
      Description = "Widget";
      PartOf = [ "graphical-session.target" ];
      After = [ "graphical-session-pre.target" ];
    };

    Service = {
      ExecStart = "${pkgs.eww}/bin/eww ";
      Restart = "on-failure";
    };

    Install = {
      WantedBy = [ "hyprland.target" ];
    };
  };



  systemd.user.services.mpvpaper = {
    Unit = {
      Description = "Animated background";
      PartOf = [ "graphical-session.target" ];
      After = [ "graphical-session-pre.target" ];
    };

    Service = {
      ExecStart = "${pkgs.mpvpaper}/bin/mpvpaper -o 'input-ipc-server=/tmp/mpv-socket no-audio --loop-playlist --panscan=1.0' ALL /home/mat/Pictures/backgrounds/live/lofi.mp4";
      Restart = "on-failure";
    };

    Install = {
      WantedBy = [ "hyprland.target" ];
    };
  };
}
