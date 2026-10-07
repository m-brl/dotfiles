{ config, pkgs, ... }:

{
  imports = [
    ./polkit/tlp.nix
    ./polkit/fan.nix
  ];

  security.rtkit.enable = true;
  security.polkit = {
    enable = true;
    enablePkexecWrapper = true;
    extraConfig = ''
      polkit.addRule(function(action, subject) {
        if ((action.id == "net.reactivated.fprint.device.verify" ||
            action.id == "net.reactivated.fprint.device.claim") &&
            subject.local == true) {
          return polkit.Result.YES;
        }

        if (subject.isInGroup("wheel")) {
          if (action.id == "org.mathieu.tlp.run" ||
              action.id == "org.mathieu.fan.control" ||
              action.id == "net.reactivated.fprint.device.enroll" ||
              action.id == "org.debian.pcsc-lite.access_card" ||
              action.id == "org.debian.pcsc-lite.access_pcsc") {
            return polkit.Result.YES;
          }
        }

        return polkit.Result.AUTH_ADMIN_KEEP;
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
