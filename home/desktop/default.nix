{ pkgs, ... }:

{
  imports = [
    ./hyprland.nix ./waybar.nix ./swaync.nix ./quickshell.nix
  ];

  services.awww = {
    enable = true;
  };

  programs.hyprlock = {
    enable = true;

    settings = {
      general = {
        screencopy_mode = 1;
      };

      background = {
        path = "screenshot";
                #color = "rgba(b7bdf8ff)";
        blur_passes = 3;
      };

      auth = {
        "fingerprint:enabled" = true;
        "fingerprint:ready_message" = "Scanning fingerprint...";
      };

      input-field = [
        {
          monitor = "";
          size = "15%, 3%";
          outline_thickness = 2;
          rounding = 6;


          position = "0, -200";
          halign = "center";
          valign = "center";

          outer_color = "rgba(6e738dff)";
          check_color = "rgba(eed49fff)";
          fail_color = "rgba(ed8796ff)";
        }
      ];

      label = [
        {
          text = "$TIME";
          font_size = "90";
          font_family = "$font";

          position = "0, -70";
          halign = "center";
          valign = "top";
        }

        {
          text = "cmd[update:60000] date +'%a %b %d'";
          font_size = "25";

          position = "0, -50";
          halign = "center";
          valign = "top";
        }
      ];

      animations = {
        enabled = true;
        bezier = "linear, 1, 1, 0, 0";
        animation = [
          "fadeIn, 1, 5, linear"
          "fadeOut, 1, 5, linear"
          "inputFieldDots, 1, 2, linear"
        ];

      };
    };
  };

  services.hypridle = {
    enable = true;
    settings = {
      general = {
        lock_cmd = "${pkgs.bash}/bin/bash -c 'pidof hyprlock || hyprlock'";
        unlock_cmd = "${pkgs.bash}/bin/bash -c 'pkill -USR1 hyprlock'";
        before_sleep_cmd = "${pkgs.bash}/bin/bash -c 'pidof hyprlock || hyprlock'";
        after_sleep_cmd = "${pkgs.bash}/bin/bash -c 'hyprctl dispatch dpms on'";
      };

      listener = [
        {
          timeout = 540;
          on-timeout = "${pkgs.bash}/bin/bash -c 'notify-send \"You are idle!\"'";
          on-resume = "${pkgs.bash}/bin/bash -c 'notify-send \"Welcome back!\"'";
        }

        {
          timeout = 600;
          on-timeout = "${pkgs.bash}/bin/bash -c 'pidof hyprlock || hyprlock'";
        }
      ];
    };
  };

  services.hyprsunset = {
    enable = true;
    settings = {
      max-gamma = 150;

      profile = [
        {
          time = "7:30";
          identity = true;
        }

        {
          time = "21:00";
          temperature = 5500;
          gamma = 0.8;
        }
      ];
    };
  };
}
