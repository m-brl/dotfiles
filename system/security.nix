{ config, pkgs, ... }:

{
  imports = [
    ./polkit/fan.nix
  ];

  security.sudo.execWheelOnly = true;
  security.rtkit.enable = true;
  security.polkit = {
    enable = true;
    enablePkexecWrapper = true;
    extraConfig = ''
      polkit.addRule(function(action, subject) {
        if (action.id == "org.freedesktop.login1.chvt") {
          return polkit.Result.YES;
        }
      });

      polkit.addRule(function(action, subject) {
        if ((action.id == "net.reactivated.fprint.device.verify" ||
            action.id == "net.reactivated.fprint.device.claim") &&
            subject.local == true) {
          return polkit.Result.YES;
        }

        if (subject.isInGroup("wheel")) {
          if (action.id == "org.mathieu.fan.control" ||
              action.id == "net.reactivated.fprint.device.enroll" ||
              action.id == "org.debian.pcsc-lite.access_card" ||
              action.id == "org.debian.pcsc-lite.access_pcsc") {
            return polkit.Result.YES;
          }
        }
      });
    '';
  };

  security.pam.u2f = {
    enable = true;
  };
  security.pam.services.sudo.u2f.enable = true;
  security.pam.services.hyprlock = {};
  security.pam.services.hyprlock.u2f.enable = true;
}
