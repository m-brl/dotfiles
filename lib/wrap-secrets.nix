{ pkgs }:

{ pkg, secrets, bin ? pkg.meta.mainProgram }:

let
  inherit (pkgs) lib;

  runFlag = name: file:
    let
      cmd = ''
        [ -r ${lib.escapeShellArg file} ] || { echo "wrap-secrets: cannot read ${file}" >&2; exit 1; }
        export ${name}="$(cat ${lib.escapeShellArg file})"
      '';
    in
    "--run ${lib.escapeShellArg cmd}";
in
pkgs.symlinkJoin {
  name = "${pkg.pname or pkg.name}-wrapped";
  paths = [ pkg ];
  nativeBuildInputs = [ pkgs.makeWrapper ];
  postBuild = ''
    wrapProgram $out/bin/${bin} \
      ${lib.concatStringsSep " \\\n      " (lib.mapAttrsToList runFlag secrets)}
  '';
  inherit (pkg) meta;
}
