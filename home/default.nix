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
    ./editors
    ./shell
    ./programs/programs.nix
    ./services.nix
    ./emails.nix
    ./drive.nix
  ];

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
      "x-scheme-handler/io.element.desktop" = [ "element-router.desktop" ];
      "x-scheme-handler/element" = [ "element-router.desktop" ];
    };
  };

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  programs.home-manager.enable = true;

  home.packages = with pkgs; [
    # Dev
    alacritty
    gemini-cmd
    vectorcode code-cursor
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
    pavucontrol easyeffects qpwgraph lsp-plugins ffmpeg easyeffects gimp

    # Game
    discord vesktop steam parsec-bin protonup-qt
    wineWow64Packages.waylandFull

    # Tools
    kdePackages.dolphin kdePackages.konsole
    modem-manager-gui
    rclone rsync
    zip unzip ripgrep fd nix-index
    wl-clipboard
    cifs-utils
  ];

  home.pointerCursor = {
    enable = true;
    package = pkgs.bibata-cursors;
    gtk.enable = true;
    x11.enable = true;
    hyprcursor.enable = true;
    name = "Bibata-Modern-Classic";
    size = 24;
  };
}
