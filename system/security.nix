{ ... }:

{
  imports = [
    ./polkit/fan.nix
  ];

  nix-mineral = {
    enable = true;
    filesystems.normal = {
      "/etc".enable = false;
      "/var".enable = false;
      "/home".enable = false;
    };
  };

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

  security = {
    pam = {
      services.hyprlock = {};
      services.sddm.gnupg.enable = true;
    };
  };
}
