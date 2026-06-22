{ ... }:

{
  imports = [
    ./hyprland.nix ./waybar.nix ./swaync.nix ./quickshell.nix
  ];

  services.awww = {
    enable = true;
  };

  programs.hyprlock = {
    enable = true;
      };

  services.hypridle = {
    enable = true;
    settings = {
      general = {
        lock_cmd = "bash -c 'pidof hyprlock || hyprlock'";
        unlock_cmd = "bash -c 'pkill -USR1 hyprlock'";
        before_sleep_cmd = "bash -c 'pidof hyprlock || hyprlock'";
        after_sleep_cmd = "bash -c 'hyprctl dispatch dpms on'";
      };

      listener = [
        {
          timeout = 540;
          on-timeout = "bash -c 'notify-send \"You are idle!\"'";
          on-resume = "bash -c 'notify-send \"Welcome back!\"'";
        }

        {
          timeout = 600;
          on-timeout = "bash -c 'pidof hyprlock || hyprlock'";
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
