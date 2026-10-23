{ pkgs }:

{ pkg
, bin ? pkg.meta.mainProgram
, args ? [ "--password-store=gnome-libsecret" ]
, stateDir ? "$HOME/.local/share/keyring-${bin}"
}:

let
  inherit (pkgs) lib;

  inner = pkgs.writeShellApplication {
    name = "${bin}-keyring-inner";
    runtimeInputs = [ pkgs.gnome-keyring ];
    text = ''
      XDG_DATA_HOME="${stateDir}" \
      gnome-keyring-daemon --unlock --components=secrets < /dev/null > /dev/null
      exec ${pkg}/bin/${bin} ${lib.escapeShellArgs args} "$@"
    '';
  };

  outer = pkgs.writeShellApplication {
    name = "${bin}-keyring";
    runtimeInputs = [ pkgs.dbus ];
    text = ''
      mkdir -p "${stateDir}"
      exec dbus-run-session --config-file=${pkgs.dbus}/share/dbus-1/session.conf -- ${inner}/bin/${bin}-keyring-inner "$@"
    '';
  };
in
  pkgs.symlinkJoin {
    name = "${pkg.pname or pkg.name}-keyring";
    paths = [ pkg ];
    postBuild = ''
      rm $out/bin/${bin}
      ln -s ${outer}/bin/${bin}-keyring $out/bin/${bin}
    '';
    inherit (pkg) meta;
  }
