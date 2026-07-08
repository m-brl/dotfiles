{ config, pkgs, ... }:

{
  security.rtkit.enable = true;
  security.polkit = {
    enable = true;
    extraConfig = ''
      polkit.addRule(function(action, subject) {
        if (action.id == "net.reactivated.fprint.device.enroll" && subject.isInGroup("wheel")) {
          return polkit.Result.YES;
        }
      });
    '';
  };

  security.pam.services.hyprlock = {};
}
