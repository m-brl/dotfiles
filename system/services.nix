{ config, pkgs, ... }:

let
  sddmTheme = pkgs.stdenv.mkDerivation {
    name = "custom-theme";
    src = ./sddm-theme;
    installPhase = ''
      mkdir -p $out/share/sddm/themes/custom-theme
      mkdir -p $out/share/sddm/themes/custom-theme
      cp -r * $out/share/sddm/themes/custom-theme
    '';
  };
in
{
  services = {
    logiops = {
      enable = true;
      config = {
        devices = [
          {
            name = "MX Master 4";
            dpi = 1000;
            buttons = [
              {
                cid = 195;
                action = {
                  type = "Gestures";
                  gestures = [
                    {
                      direction = "Right";
                      mode = "OnRelease";
                      action = {
                        type = "Keypress";
                        keys = ["KEY_LEFTALT" "KEY_L"];
                      };
                    }
                    {
                      direction = "Left";
                      mode = "OnRelease";
                      action = {
                        type = "Keypress";
                        keys = ["KEY_LEFTALT" "KEY_H"];
                      };
                    }
                  ];
                };
              }
              {
                cid = 416;
                action = {
                  type = "Gestures";
                  gestures = [
                    {
                      direction = "Up";
                      mode = "OnRelease";
                      action = {
                        type = "Keypress";
                        keys = ["KEY_RIGHTALT" "KEY_L"];
                      };
                    }
                  ];
                };
              }
            ];
          }
        ];
      };
    };

    thinkfan = {
      enable = true;
      smartSupport = true;
    };
    dbus.packages = [ pkgs.pass-secret-service ];

    gvfs.enable = true;
    protonmail-bridge.enable = true;
    printing = {
      enable = true;
      drivers = [ pkgs.epson-escpr2 ];
    };

    displayManager.sddm = {
      enable = true;
      wayland.enable = true;
      package = pkgs.kdePackages.sddm;
      theme = "custom-theme";
      extraPackages = [ pkgs.adwaita-icon-theme ];

      settings = {
        Theme = {
          CursorTheme = "Adwaita";
        };
      };
    };

    pcscd.enable = true;
    flatpak.enable = true;

    gnome.gnome-keyring.enable = false;

    blueman.enable = true;

    xserver = {
      enable = true;
      videoDrivers = [ "nvidia" ];
      xkb.layout = "us";
      xkb.variant = "altgr-intl";
    };

    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
    };

    udev = {
      enable = true;
      extraRules = ''
      KERNEL=="hidraw*", SUBSYSTEM=="hidraw", ATTRS{idVendor}=="3434",  MODE="0660", GROUP="users", TAG+="uaccess"
      '';
      packages = [
        pkgs.yubikey-personalization
        pkgs.libu2f-host
        pkgs.libfido2
      ];
    };

    power-profiles-daemon.enable = false;
    tlp = {
      enable = true;
      settings = {
        START_CHARGE_THRESH_BAT0 = 75;
        STOP_CHARGE_THRESH_BAT0 = 81;
      };
    };

    tailscale = {
      enable = true;
    };

    qbittorrent = {
      enable = false;
    };

    cron = {
      enable = true;
      systemCronJobs = [
      ];
    };

    fprintd.enable = true;


    upower = {
      enable = true;
    };
  };
  environment.systemPackages = [ sddmTheme ];
}
