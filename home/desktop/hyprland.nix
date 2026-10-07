{ config, pkgs, inputs, ... }:

{
  #programs.niri = {
  #  settings = {
  #    prefer-no-csd = true;

  #    binds = with config.lib.niri.actions; {
  #      "Mod+Return".action = spawn "kitty";
  #    };
  #  };
  #};

  wayland.windowManager.hyprland = {
    enable = true;
    configType = "hyprlang";
    systemd.enable = false;
    systemd.enableXdgAutostart = true;

    settings = {
      debug = {
        error_limit = 3;
      };

      misc = {
        mouse_move_enables_dpms = true;
        key_press_enables_dpms = true;
      };

      monitor = [
        "eDP-1, 1920x1200@60.0, 0x0, 1.0"
      ];

      exec-once = [
        "wl-paste --watch cliphist store"
      ];

      env = [
        "LIBVA_DRIVER_NAME,nvidia"
        "__GLX_VENDOR_LIBRARY_NAME,nvidia"
        "GBM_BACKEND,nvidia-drm"
      ];

      general = {
        gaps_in = 5;
        gaps_out = 5;

        border_size = 2;

        "col.active_border" = "rgba(5e81acff)";
        "col.inactive_border" = "rgba(181825ee)";

        resize_on_border = false;

        allow_tearing = false;

        layout = "dwindle";
      };

      group = {
        "col.border_active" = "rgba(5e81acff)";
        "col.border_inactive" = "rgba(181825ff)";

        "col.border_locked_active" = "rgba(f38ba8ff)";
        "col.border_locked_inactive" = "rgba(181825ff)";

        groupbar = {
          enabled = true;
          font_size = 11;

          "col.active" = "rgba(5e81acff)";
          "col.inactive" = "rgba(181825ff)";

          "col.locked_active" = "rgba(f38ba8ff)";
          "col.locked_inactive" = "rgba(181825ff)";
        };
      };

      dwindle = {
        preserve_split = true;
      };

      cursor = {
        no_hardware_cursors = false;
      };

      input = {
        kb_layout = "us";
        follow_mouse = 1;
        accel_profile = "adaptive";

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
          passes = 3;

          vibrancy = 0.1696;
        };
      };



      animations = {
        enabled = "yes";

        bezier = [
          "easeOutQuint,0.23,1,0.32,1"

          "easeInOutCubic,0.65,0.05,0.36,1"
          "easeInBack, 0.7, 0, 0.84, 0"

          "linear,0,0,1,1"

          "almostLinear,0.5,0.5,0.75,1.0"

          "quick,0.15,0,0.1,1"

          "popOut, 0.175,0.885,0.32,1.15"

          "macWorkspace,0.16,1,0.3,1"
        ];

        animation = [
          "global, 1, 10, default"

          "border, 1, 5.39, default"
          "borderangle, 1, 100, linear, loop"

          "windowsIn, 1, 6, popOut, popin 10%"
          "windowsOut, 1, 4, easeInBack, popin 80%"

          "fadeIn, 1, 1.73, almostLinear"
          "fadeOut, 1, 1.46, almostLinear"
          "fade, 1, 3.03, quick"

          "layers, 1, 3.81, easeOutQuint"
          "layersIn, 1, 4, easeOutQuint, fade"
          "layersOut, 1, 1.5, linear, fade"

          "fadeLayersIn, 1, 1.79, almostLinear"
          "fadeLayersOut, 1, 1.39, almostLinear"

          "workspaces, 1, 5, macWorkspace, slide"
        ];
      };
    };

    extraConfig = builtins.readFile ./hyprland-binds.conf;
  };
}
