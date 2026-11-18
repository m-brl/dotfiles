{ pkgs, lib, inputs, ... }:

{
  imports = [
    ./editors
    ./librewolf
    ./shell
    ./apps.nix
    ./claude.nix
    ./cli.nix
    ./element.nix
    ./emails.nix
    ./gpg.nix
    ./hyprland.nix
    ./newsboat.nix
    ./quickshell.nix
    ./services.nix
    ./swaync.nix
    ./terminals.nix
  ];

  home.username = "mathieu";
  home.homeDirectory = "/home/mathieu";
  home.stateVersion = "25.11";

  programs.home-manager.enable = true;

  xdg = {
    mimeApps = {
      enable = true;

      defaultApplications = {
        "text/html" = [ "librewolf.desktop" ];
        "x-scheme-handler/http" = [ "librewolf.desktop" ];
        "x-scheme-handler/https" = [ "librewolf.desktop" ];
        "x-scheme-handler/about" = [ "librewolf.desktop" ];
        "x-scheme-handler/unknown" = [ "librewolf.desktop" ];
        "x-scheme-handler/io.element.desktop" = [ "element-router.desktop" ];
        "x-scheme-handler/element" = [ "element-router.desktop" ];
      };
    };

    terminal-exec = {
      enable = true;
      settings = {
        default = [
          "kitty.desktop"
        ];
      };
    };
  };

  home.sessionVariables = {
    EDITOR = "nvim";
    TERMINAL = "kitty";
  };

  home.packages = with pkgs; [
    # Dev
    devenv
    clang cmake pkg-config gnumake ninja cgdb gdb valgrind
    patchelf
    uv pixi
    python314
    ed
    fzf
    alacritty
    obsidian
    jetbrains.clion jetbrains.idea jetbrains.pycharm jetbrains.mps
    kicad
    quickshell
    obs-studio
    cura-appimage
    freecad

    # Browser
    brave vivaldi chromium libreoffice tor-browser

    # DE
    hyprlauncher hyprcursor mpvpaper rofi nwg-displays wofi
    wl-clipboard cliphist wlr-randr
    playerctl brightnessctl
    libnotify
    solaar

    # Multimedia
    pavucontrol qpwgraph lsp-plugins ffmpeg gimp

    # Game
    steam parsec-bin protonup-qt
    wineWow64Packages.waylandFull

    # Tools
    rclone rsync
    zip unzip ripgrep fd
    kdePackages.dolphin kdePackages.konsole
    cifs-utils
  ];

  services.awww = {
    enable = true;
  };

  systemd.user.services.awww-wallpaper = {
    Unit = {
      Description = "Define awww wallpaper";
      After = [ "awww.service" ];
      Requires = [ "awww.service" ];
      PartOf = [ "awww.service" ];
    };

    Service = {
      Type = "oneshot";
      RemainAfterExit = true;
      ExecStartPre = "${pkgs.bash}/bin/bash -c 'until ${lib.getExe pkgs.awww} query; do sleep 0.2; done'";
      ExecStart = "${lib.getExe pkgs.awww} img ${inputs.image-collection}/images/Firewatch-pencil.png";
    };

    Install.WantedBy = [ "awww.service" ];
  };

  services.cliphist = {
    enable = true;
    allowImages = true;
  };

  programs.hyprlock = {
    enable = true;

    settings = {
      general = {
        screencopy_mode = 1;
      };

      background = {
        path = "screenshot";
        blur_passes = 3;
      };

      auth = {
        "fingerprint:enabled" = true;
        "fingerprint:ready_message" = "Scanning fingerprint...";
      };

      input-field = {
          monitor = "";
          size = "15%, 3%";
          outline_thickness = 2;
          rounding = 6;


          position = "0, -200";
          halign = "center";
          valign = "center";
      };

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

  systemd.user.services.polkit = {
    Unit = {
      Description = "Polkit Authentication Agent";
      Wants = [ "graphical-session.target" ];
      After = [ "graphical-session.target" ];
    };
    Install = {
      WantedBy = [ "graphical-session.target" ];
    };
    Service = {
      Type = "simple";
      ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
      Restart = "on-failure";
      RestartSec = 1;
      TimeoutStopSec = 10;
    };
  };
}
