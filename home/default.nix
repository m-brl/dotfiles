{ config, pkgs, inputs, ... }:

let 
  gemini-cmd = pkgs.writeShellScriptBin "gemini" ''
    export PATH="${pkgs.nodejs_24}/bin:$PATH"
    exec ${pkgs.nodejs_24}/bin/npx @google/gemini-cli "$@"
  '';
in
{
  imports = [
    ./desktop
    ./shell/zsh.nix ./shell/direnv.nix  ./shell/git.nix  ./shell/tmux.nix ./shell/kitty.nix
    ./editors/vim.nix ./editors/neovim.nix
    ./programs/programs.nix
    ./emails.nix
    inputs.catppuccin.homeModules.catppuccin
  ];

  catppuccin = {
    enable = true;
    flavor = "mocha";
    accent = "mauve";
    hyprland.enable = false;
    tmux.enable = false;
  };

  home.username = "mathieu";
  home.homeDirectory = "/home/mathieu";
  home.stateVersion = "25.11";

  xdg.mimeApps = {
    enable = true;

    defaultApplications = {
      "text/html" = [ "brave.desktop" ];
      "x-scheme-handler/http" = [ "brave.desktop" ];
      "x-scheme-handler/https" = [ "brave.desktop" ];
      "x-scheme-handler/about" = [ "brave.desktop" ];
      "x-scheme-handler/unknown" = [ "brave.desktop" ];
    };
  };

  home.sessionVariables = {
  };

  programs.home-manager.enable = true;

  programs.kitty.enable = true;
    
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

  home.packages = with pkgs; [
    # Dev
    gemini-cmd gh
    clang cmake pkg-config gnumake ninja cgdb gdb valgrind
    patchelf
    uv
    python313
    jetbrains.clion jetbrains.idea jetbrains.pycharm jetbrains.mps
    kicad
    quickshell
    obs-studio

    # Browser
    brave chromium libreoffice

    # DE
    hyprlauncher hyprcursor mpvpaper rofi nwg-displays wofi
    pass-wayland
    wl-clipboard cliphist
    playerctl brightnessctl
    libnotify

    # Multimedia
    pavucontrol easyeffects qpwgraph lsp-plugins ffmpeg easyeffects

    # Game
    discord vesktop steam parsec-bin protonup-qt
    wineWow64Packages.waylandFull

    # Tools
    kdePackages.dolphin kdePackages.konsole
    rclone rsync
    zip unzip ripgrep nix-index
    wl-clipboard
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
