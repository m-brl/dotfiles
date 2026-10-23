{ config, pkgs, slib, inputs, ... }:

let
  jail = inputs.jail-nix.lib.init pkgs;

  vesktop-jailed =
    jail "vesktop" pkgs.vesktop
      (with jail.combinators; [
        network
        gui
        gpu
        pipewire

        (dbus { talk = [ "org.freedesktop.portal.*" ]; })

        (readwrite (noescape "~/.config/vesktop"))
        (readwrite (noescape "~/.local/share/keyring-vesktop"))
        (readwrite (noescape "~/Downloads"))
      ]);
in
{
  imports = [
    ./common.nix
    ./desktop
    ./shell/kitty.nix
    ./programs
    ./services.nix
    ./emails.nix
    ./drive.nix
  ];

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
    TERMINAL = "kitty";
  };

  home.packages = with pkgs; [
    # Dev
    alacritty
    obsidian
    jetbrains.clion jetbrains.idea jetbrains.pycharm jetbrains.mps
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
    pavucontrol qpwgraph lsp-plugins ffmpeg gimp

    # Game
    (lib.hiPrio vesktop-jailed) vesktop steam parsec-bin protonup-qt
    wineWow64Packages.waylandFull

    # Tools
    kdePackages.dolphin kdePackages.konsole
    modem-manager-gui
    wl-clipboard
    cifs-utils
  ];
}
