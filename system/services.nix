{ lib, config, pkgs, ... }:

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

    ollama = {
      enable = true;
      package = pkgs.ollama-cuda;
      loadModels = [
        "mxbai-embed-large"
      ];
    };


    dbus.packages = [ pkgs.pass-secret-service ];

    gvfs.enable = true;

    protonmail-bridge.enable = true;

    tor = {
      enable = true;
      settings = {
        SOCKSPort = 9050;
      };
    };

    printing = {
      enable = true;
      drivers = [ pkgs.epson-escpr2 ];
    };

    displayManager.sddm = {
      enable = true;
      wayland.enable = true;
      package = pkgs.kdePackages.sddm;
      extraPackages = [ pkgs.adwaita-icon-theme ];

      settings = {
        Theme = {
          CursorTheme = "Adwaita";
        };
      };
    };

    pcscd.enable = true;
    flatpak.enable = true;

    gnome.gnome-keyring.enable = lib.mkForce false;

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
      pd.enable = true;
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

    openssh = {
      enable = true;
      settings = {
        PermitRootLogin = "no";
        PasswordAuthentication = false;
      };
    };

    fprintd.enable = true;

    upower = {
      enable = true;
    };

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
  };
  environment.systemPackages = [ sddmTheme ];
}
