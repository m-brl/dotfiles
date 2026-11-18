{ pkgs, ... }:

{
  programs = {
    vscode = {
      enable = true;
    };

    thunderbird = {
      enable = true;
      profiles = {
        mathieu = {
          isDefault = true;
        };
      };
    };

    keepassxc = {
      enable = true;
    };

    vesktop = {
      enable = true;
      vencord = {
        mutableSettings = true;
        settings.plugins.VoiceNormalizer.enabled = true;
      };
    };
  };

  systemd.user.services.stremio = {
    Unit = {
      Description = "Stremio Service";
      After = [ "graphical-session.target" ];
      Wants = [ "graphical-session.target" ];
      PartOf = [ "graphical-session.target" ];
    };

    Service = {
      Type = "simple";
      ExecStart = "${pkgs.stremio-service}/bin/stremio-service";
    };

    Install = {
      WantedBy = [ "graphical-session.target" ];
    };
  };
}
