{ config, pkgs, inputs, ... }:

{
  wayland.windowManager.hyprland = {
    enable = true;
    configType = "hyprlang";
    systemd.enable = false;
    systemd.enableXdgAutostart = true;

    settings = {
      debug = {
        error_limit = 3;
      };

      monitor = [
        "eDP-1, 1920x1200@60.0, 0x0, 1.0"
        "DP-2, 1920x1080@60.0, 1920x0, 1.0"
      ];

      exec-once = [
        "wl-paste --watch cliphist store"
      ];

      env = [
        "LIBVA_DRIVER_NAME,nvidia"
        "XDG_SESSION_TYPE,wayland"
        "GBM_BACKEND,nvidia-drm"
        "__GLX_VENDOR_LIBRARY_NAME,nvidia"
        "__NV_PRIME_RENDER_OFFLOAD,1"
        "NVD_BACKEND,direct"
      ];

      general = {
        gaps_in = 5;
        gaps_out = 5;

        border_size = 1;

        "col.active_border" = "rgba(8a9bebff)";
        "col.inactive_border" = "rgba(777777ee)";

        resize_on_border = false;

        allow_tearing = false;

        layout = "dwindle";
      };

      dwindle = {
        preserve_split = true;
      };

      input = {
        kb_layout = "us";
        follow_mouse = 1;

        sensitivity = 0;

        touchpad = {
          natural_scroll = false;
        };
      };

      device = [
        {
          name = "at-translated-set-2-keyboard";
          kb_layout = "us";
          kb_options = "compose:ralt";
        }

        {
          name = "keychron--keychron-link--keyboard";
          kb_layout = "us";
          kb_options = "compose:ralt";
        }

        { 
          name = "keychron-keychron-q3-max";
          kb_layout = "us";
          kb_options = "compose:ralt";
        }
      ];

      decoration = {
        rounding = 5;
        rounding_power = 2;


        active_opacity = 1.0;
        inactive_opacity = 1.0;

        shadow = {
          enabled = true;
          range = 4;
          render_power = 3;
          color = "rgba(1a1a1aee)";
        };

        blur = {
          enabled = true;
          size = 3;
          passes = 1;

          vibrancy = 0.1696;
        };
      };



      animations = {
        enabled = "yes";

        bezier = [
          "easeOutQuint,0.23,1,0.32,1"
          "easeInOutCubic,0.65,0.05,0.36,1"
          "linear,0,0,1,1"
          "almostLinear,0.5,0.5,0.75,1.0"
          "quick,0.15,0,0.1,1"
        ];

        animation = [
          "global, 1, 10, default"
          "border, 1, 5.39, easeOutQuint"
          "windows, 1, 4.79, easeOutQuint"
          "windowsIn, 1, 4.1, easeOutQuint, popin 87%"
          "windowsOut, 1, 1.49, linear, popin 87%"
          "fadeIn, 1, 1.73, almostLinear"
          "fadeOut, 1, 1.46, almostLinear"
          "fade, 1, 3.03, quick"
          "layers, 1, 3.81, easeOutQuint"
          "layersIn, 1, 4, easeOutQuint, fade"
          "layersOut, 1, 1.5, linear, fade"
          "fadeLayersIn, 1, 1.79, almostLinear"
          "fadeLayersOut, 1, 1.39, almostLinear"
          "workspaces, 1, 1.94, almostLinear, fade"
          "workspacesIn, 1, 1.21, almostLinear, fade"
          "workspacesOut, 1, 1.94, almostLinear, fade"
        ];
      };
    };

    extraConfig = builtins.readFile ./hyprland-binds.conf;
  };
}
