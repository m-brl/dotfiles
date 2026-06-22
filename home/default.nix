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
      "text/html" = [ "vivaldi-stable.desktop" ];
      "x-scheme-handler/http" = [ "vivaldi-stable.desktop" ];
      "x-scheme-handler/https" = [ "vivaldi-stable.desktop" ];
      "x-scheme-handler/about" = [ "vivaldi-stable.desktop" ];
      "x-scheme-handler/unknown" = [ "vivaldi-stable.desktop" ];
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
    gemini-cmd gh
    clang cmake pkg-config gnumake ninja cgdb gdb valgrind
    patchelf
    uv
    python313
    ed jetbrains.clion jetbrains.idea jetbrains.pycharm jetbrains.mps
    kicad
    quickshell
    obs-studio

    # Browser
    brave vivaldi chromium libreoffice tor-browser

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
