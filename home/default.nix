{ config, pkgs, inputs, ... }:

let 
in
{
  imports = [
    ./desktop
    ./editors
    ./shell
    ./programs
    ./services.nix
    ./emails.nix
    ./drive.nix
  ];

  home.username = "mathieu";
  home.homeDirectory = "/home/mathieu";
  home.stateVersion = "25.11";

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

  programs.home-manager.enable = true;

  home.packages = with pkgs; [
    # Dev
    devenv
    alacritty
    vectorcode
    obsidian
    clang cmake pkg-config gnumake ninja cgdb gdb valgrind
    patchelf
    uv pixi
    python314
    ed jetbrains.clion jetbrains.idea jetbrains.pycharm jetbrains.mps
    kicad
    quickshell
    obs-studio
    cura-appimage
    fzf

    # Browser
    brave vivaldi chromium libreoffice tor-browser
    oama libsecret

    # DE
    hyprlauncher hyprcursor mpvpaper rofi nwg-displays wofi
    wl-clipboard cliphist wlr-randr
    playerctl brightnessctl
    libnotify
    pass-wayland
    solaar

    # Multimedia
    pavucontrol qpwgraph lsp-plugins ffmpeg gimp

    # Game
    discord vesktop steam parsec-bin protonup-qt
    wineWow64Packages.waylandFull

    # Tools
    kdePackages.dolphin kdePackages.konsole
    modem-manager-gui
    rclone rsync
    zip unzip ripgrep fd
    wl-clipboard
    cifs-utils
  ];
}
