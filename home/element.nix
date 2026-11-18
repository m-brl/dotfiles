{ config, inputs, lib, slib, pkgs, ... }:

let
  home = config.home.homeDirectory;
  jail = inputs.jail-nix.lib.init pkgs;

  accounts = [
    {
      id = "matrix";
      url = "matrix.org";
    }
    {
      id = "lucy";
      url = "lucy-robotics.com";
    }
  ];

  mkElement = account:
    let
      id = lib.toLower account.id;
      url = account.url;
      profile = "${home}/.config/Element-${id}";
    in
    {
      inherit id url;
      package =
        jail "element-${id}"
          (slib.wrapKeyring {
            pkg = pkgs.element-desktop;
            stateDir = "${home}/.local/share/keyring-element-${id}";
            args = [ "--password-store=gnome-libsecret" "--user-data-dir=${profile}" ];
          })
          (with jail.combinators; [
            network
            gui
            gpu
            pipewire

            (readwrite (noescape profile))
            (readwrite (noescape "${home}/.local/share/keyring-element-${id}"))
            (readwrite (noescape "~/Downloads"))
          ]);
    };

  elements = map mkElement accounts;

  elementRouter = pkgs.writeShellScriptBin "element-router" ''
    URL="$1"

    app=$(${pkgs.zenity}/bin/zenity --list \
      --title="Element Application Router" \
      --text="Select an app to open link with" \
      --column="App" \
      "Perso (matrix.org)" \
      "Pro (lucy-robotics.com)" \
      --width=300 --height=250)

    case $app in
      ${lib.concatMapStringsSep "\n" (element: ''
        "${element.id}") exec ${element.package}/bin/element-${element.id} "$@" ;;
      '') elements}
    esac
  '';
in
{

  home.packages = 
    (map (e: e.package) elements)
    ++ (map (e:
      pkgs.makeDesktopItem {
        name = "element-${e.id}";
        desktopName = "Element ${e.id}";
        exec = "${e.package}/bin/element-${e.id} %u";
        icon = "${pkgs.element-desktop}/share/icons/hicolor/512x512/apps/element.png";
        categories = [ "Network" "Chat" "InstantMessaging" ];
      }) elements);

  xdg.desktopEntries.element-router = {
    name = "Element Router";
    exec = "${elementRouter}/bin/element-router %u";
    mimeType = [ "x-scheme-handler/io.element.desktop" "x-scheme-handler/element" ];
    noDisplay = true;
  };
}
