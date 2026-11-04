{ lib, config, ... }:

let
  mkMonitor = {output, mode, position, scale ? 1.0}: {
    inherit output mode position scale;
  };

  mkKeyboard = {name, kb_layout ? "us", kb_options ? "compose:ralt"} : {
    inherit name kb_layout kb_options;
  };

  mkBezier = {name, type ? "bezier", points}: {
    _args = [
      name
      { inherit type points; }
    ];
  };

  mkAnimation = {leaf, enabled ? true, speed, bezier, style ? null}:
    { inherit leaf enabled speed bezier; }
    // lib.optionalAttrs (style != null) { inherit style; };
in
{
  imports = [
    ./hyprland-binds.nix
  ];

  stylix.targets.hyprland.enable = true;

  wayland.windowManager.hyprland = {
    enable = true;
    configType = "lua";

    systemd.enable = false;
    systemd.enableXdgAutostart = true;

    settings = {
      monitor = [
        (mkMonitor { output = "eDP-1"; mode = "1920x1200@60.0"; position = "0x0"; scale = 1.0; })
      ];

      device = [
        (mkKeyboard { name = "at-translated-set-2-keyboard"; } )
        (mkKeyboard { name = "keychron--keychron-link--keyboard"; } )
        (mkKeyboard { name = "keychron-keychron-q3-max"; } )
      ];

      config = {
        animations.enabled = true;
        binds.movefocus_cycles_groupfirst = true;

        debug = {
          error_limit = 3;
        };

        misc = {
          mouse_move_enables_dpms = true;
          key_press_enables_dpms = true;
        };

        general = {
          gaps_in = 5;
          gaps_out = 5;

          border_size = 2;

          resize_on_border = false;

          allow_tearing = false;

          layout = "dwindle";
        };

        group = {
          groupbar = {
            enabled = true;
            font_size = 11;
          };
        };

        dwindle = {
          preserve_split = true;
        };

        cursor = {
          # Hardware cursor blit to the dGPU outputs fails
          no_hardware_cursors = true;
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

        decoration = {
          rounding = 5;
          rounding_power = 2;

          active_opacity = 1.0;
          inactive_opacity = 1.0;

          shadow = {
            enabled = true;
            range = 4;
            render_power = 3;
          };

          blur = {
            enabled = true;
            size = 3;
            passes = 3;

            vibrancy = 0.1696;
          };
        };
      };

      curve = [
        (mkBezier { name = "easeOutQuint";   points = [ [ 0.23 1 ]       [ 0.32 1 ] ]; })
        (mkBezier { name = "easeInOutCubic"; points = [ [ 0.65 0.05 ]    [ 0.36 1 ] ]; })
        (mkBezier { name = "easeInBack";     points = [ [ 0.7 0 ]        [ 0.84 0 ] ]; })
        (mkBezier { name = "linear";         points = [ [ 0 0 ]          [ 1 1 ] ]; })
        (mkBezier { name = "almostLinear";   points = [ [ 0.5 0.5 ]      [ 0.75 1.0 ] ]; })
        (mkBezier { name = "quick";          points = [ [ 0.15 0 ]       [ 0.1 1 ] ]; })
        (mkBezier { name = "popOut";         points = [ [ 0.175 0.885 ]  [ 0.32 1.15 ] ]; })
        (mkBezier { name = "macWorkspace";   points = [ [ 0.16 1 ]       [ 0.3 1 ] ]; })
      ];

      animation = [
        (mkAnimation { leaf = "global";        enabled = true; speed = 10;   bezier = "default"; })

        (mkAnimation { leaf = "border";        enabled = true; speed = 5.39; bezier = "default"; })
        (mkAnimation { leaf = "borderangle";   enabled = true; speed = 100;  bezier = "linear"; style = "loop"; })

        (mkAnimation { leaf = "windowsIn";     enabled = true; speed = 6;    bezier = "popOut"; style = "popin 10%"; })
        (mkAnimation { leaf = "windowsOut";    enabled = true; speed = 4;    bezier = "easeInBack"; style = "popin 80%"; })

        (mkAnimation { leaf = "fadeIn";        enabled = true; speed = 1.73; bezier = "almostLinear"; })
        (mkAnimation { leaf = "fadeOut";       enabled = true; speed = 1.46; bezier = "almostLinear"; })
        (mkAnimation { leaf = "fade";          enabled = true; speed = 3.03; bezier = "quick"; })

        (mkAnimation { leaf = "layers";        enabled = true; speed = 3.81; bezier = "easeOutQuint"; })
        (mkAnimation { leaf = "layersIn";      enabled = true; speed = 4;    bezier = "easeOutQuint"; style = "fade"; })
        (mkAnimation { leaf = "layersOut";     enabled = true; speed = 1.5;  bezier = "linear"; style = "fade"; })

        (mkAnimation { leaf = "fadeLayersIn";  enabled = true; speed = 1.79; bezier = "almostLinear"; })
        (mkAnimation { leaf = "fadeLayersOut"; enabled = true; speed = 1.39; bezier = "almostLinear"; })

        (mkAnimation { leaf = "workspaces";    enabled = true; speed = 5; bezier = "macWorkspace"; style = "slide"; })
      ];
    };

    extraConfig = ''
      package.path = "${config.home.homeDirectory}/.config.hypr/?.lua;" .. package.path
      require("monitors")
    '';
  };
}
