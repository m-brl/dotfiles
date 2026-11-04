{ pkgs, ... }:

{
  imports = [
    ./librewolf
#    ./openclaw.nix
    ./element.nix
    ./newsboat.nix
    ./cookie.nix
  ];

  programs = {
    btop.package = pkgs.btop.override { cudaSupport = true; };

    vscode = {
      enable = true;
    };

    password-store = {
      enable = true;
      package = pkgs.pass-wayland.withExtensions (exts: [ exts.pass-otp ]);
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
