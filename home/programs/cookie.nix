{ config, pkgs, ... }:

let
  display = ":100";
  gameDir = "${config.home.homeDirectory}/.local/share/Steam/steamapps/common/Cookie Clicker/resources/app";
  game = pkgs.writeShellScript "cookieclicker-game" ''
    unset WAYLAND_DISPLAY
    exec ${pkgs.electron}/bin/electron --ozone-platform=x11 "${gameDir}"
  '';
  startScript = pkgs.writeShellScript "cookieclicker-start" ''
    exec ${pkgs.xpra}/bin/xpra start ${display} \
      --daemon=no \
      --attach=no \
      --systemd-run=no \
      --exit-with-children=yes \
      --pulseaudio=no \
      --notifications=no \
      --mdns=no \
      --sharing=no \
      --start-child=${game}
  '';
in
{
  home.packages = [ pkgs.xpra ];

  home.shellAliases.cookie = "xpra attach ${display}";

  systemd.user.services.cookieclicker = {
    Unit.Description = "Cookie Clicker Service (Electron)";
    Service = {
      ExecStart = "${startScript}";
      ExecStop = "${pkgs.xpra}/bin/xpra stop ${display}";
      Restart = "always";
      RestartSec = 10;
    };
    Install.WantedBy = [ "default.target" ];
  };
}
