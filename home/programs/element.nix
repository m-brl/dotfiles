{ config, pkgs, ... }:

let
  username = "mathieu";
  accounts = [ "matrix.org" "sentience-robotics.com" ];

  elementRouter = pkgs.writeShellScriptBin "element-router" ''
    URL="$1"

    app=$(${pkgs.zenity}/bin/zenity --list \
      --title="Element Application Router" \
      --text="Select an app to open link with" \
      --column="App" \
      "Perso (matrix.org)" \
      "Pro (sentience-robotics.com)" \
      --width=300 --height=250)

    case $app in
      "Perso (matrix.org)")
        exec ${pkgs.element-desktop}/bin/element-desktop --password-store="gnome-libsecret" --user-data-dir="/home/${username}/.config/Element-matrix.org" "$URL"
        ;;
      "Pro (sentience-robotics.com)")
        exec ${pkgs.element-desktop}/bin/element-desktop --password-store="gnome-libsecret" --user-data-dir="/home/${username}/.config/Element-sentience-robotics.com" "$URL"
        ;;
      *)
        ;;
    esac
  '';
in
{

  home.packages = with pkgs; [
  ] ++ (map (account:
    let
      account_lower = pkgs.lib.toLower account;
    in
      makeDesktopItem {
        name = "element-${account_lower}";
        desktopName = "Element ${account}";
        exec = "${element-desktop}/bin/element-desktop --password-store=\"gnome-libsecret\" --user-data-dir=\"/home/${username}/.config/Element-${account_lower}\" %u";
        icon = "${element-desktop}/share/icons/hicolor/512x512/apps/element.png";
        categories = [ "Network" "Chat" "InstantMessaging" ];
      }
  ) accounts);

  xdg.desktopEntries.element-router = {
    name = "Element Router";
    exec = "${elementRouter}/bin/element-router %u";
    mimeType = [ "x-scheme-handler/io.element.desktop" "x-scheme-handler/element" ];
    noDisplay = true;
  };
}
