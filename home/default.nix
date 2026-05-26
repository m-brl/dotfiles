{ config, pkgs, inputs, ... }:

let 
  gemini-cmd = pkgs.writeShellScriptBin "gemini" ''
    export PATH="${pkgs.nodejs_24}/bin:$PATH"
    exec ${pkgs.nodejs_24}/bin/npx @google/gemini-cli "$@"
  '';
in
{
  imports = [
    ./shell/zsh.nix ./shell/direnv.nix  ./shell/git.nix  ./shell/tmux.nix ./shell/kitty.nix
    ./editors/vim.nix ./editors/neovim.nix
    ./desktop/hyprland.nix ./desktop/waybar.nix
    inputs.catppuccin.homeModules.catppuccin
  ];

  catppuccin = {
    enable = true;
    flavor = "macchiato";
    accent = "blue";
    hyprland.enable = false;
  };


  home.username = "mathieu";
  home.homeDirectory = "/home/mathieu";
  home.stateVersion = "25.11";

  xdg.mimeApps = {
    enable = true;

    defaultApplications = {
      "text/html" = [ "librewolf.desktop" ];
      "x-scheme-handler/http" = [ "librewolf.desktop" ];
      "x-scheme-handler/https" = [ "librewolf.desktop" ];
      "x-scheme-handler/about" = [ "librewolf.desktop" ];
      "x-scheme-handler/unknown" = [ "librewolf.desktop" ];
    };
  };

  home.sessionVariables = {
    BROWSER = "librewolf";
  };

  programs.home-manager.enable = true;

  programs.kitty.enable = true;
    
  programs.hyprlock = {
    enable = true;
    settings = {
      "$font" = "SF Pro Display";

      general = {
        hide_cursor = true;
      };

      background = {
        path = "${./desktop/assets/boliviainteligente-37WxvlfW3to-unsplash.jpg}";
      };

      input-field = {
        size = "15%, 3%";
        outline_thickness = 1;
        inner_color = "rgba(0, 0, 0, 0.0)";

        outer_color = "rgba(ffffffee)";
        check_color = "rgba(777777ee)";
        fail_color = "rgba(ff6633ee)";

        font_color = "rgb(143, 143, 143)";
        fade_on_empty = "true";
        fade_timeout = "2000";
        rounding = 5;

        font_family = "$font";
        placeholder_text = "Input password...";
        fail_text = "$PAMFAIL";

        dots_spacing = 0.3;

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
          text = "cmd[update:60000] date +\"%a %b %d\"";
          font_size = 25;
          font_family = "$font";

          position = "0, -50";
          halign = "center";
          valign = "top";
        }
      ];
    };
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

  home.packages = with pkgs; [
    # Dev
    gemini-cmd
    clang cmake pkg-config gnumake ninja cgdb gdb valgrind
    patchelf
    uv
    python313
    jetbrains.clion jetbrains.idea jetbrains.pycharm jetbrains.mps
    kicad
    quickshell
    obs-studio

    # Browser
    librewolf brave chromium libreoffice thunderbird

    # DE
    hyprlauncher hyprcursor mpvpaper rofi nwg-displays wofi
    wl-clipboard cliphist
    playerctl brightnessctl
    libnotify

    # Multimedia
    pavucontrol easyeffects qpwgraph lsp-plugins ffmpeg

    # Game
    discord vesktop steam parsec-bin protonup-qt
    wineWow64Packages.waylandFull

    # Tools
    kdePackages.dolphin kdePackages.konsole
    rclone rsync
    zip unzip ripgrep nix-index
  ];

  home.pointerCursor = {
    package = pkgs.bibata-cursors;
    gtk.enable = true;
    x11.enable = true;
    hyprcursor.enable = true;
    name = "Bibata-Modern-Classic";
    size = 24;
  };


}
