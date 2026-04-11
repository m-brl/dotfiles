{ config, pkgs, ... }:

{
  systemd.user.services.rpc-presence = {
    Unit = {
      Description = "RPC Presence";
      PartOf = [ "graphical-session.target" ];
      After = [ "graphical-session-pre.target" ];
    };

    Service = {
      ExecStart = "/home/mat/Projects/Personal/lavie/.venv/bin/python3 /home/mat/Projects/Personal/lavie/presence.py";
    };

    Install = {
      WantedBy = [ "hyprland.target" ];
    };
  };

}
