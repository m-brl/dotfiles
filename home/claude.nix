{ pkgs, inputs, lib, slib, osConfig, config, ... }:

let
  jail = inputs.jail-nix.lib.init pkgs;
  home = config.home.homeDirectory;

  commonJailOptions = with jail.combinators; [
    network
    time-zone
    no-new-session

    wayland
    (add-pkg-deps [ pkgs.wl-clipboard pkgs.gnugrep ])

    mount-cwd

    (readwrite (noescape "${home}/.claude"))
    (readwrite (noescape "${home}/.config/git"))
    (readwrite (noescape "${home}/Projects"))
    (readwrite (noescape "/nix/store"))

    (set-env "SHELL" "${pkgs.bashInteractive}/bin/bash")

    (fwd-env "TERM")
    (fwd-env "TERMINAL")
    (fwd-env "TERMINFO")
    (fwd-env "KITTY_WINDOW_ID")
    (fwd-env "ZELLIJ")
    (fwd-env "ZELLIJ_SESSION_NAME")
    (fwd-env "ZELLIJ_PANE_ID")

    (fwd-env "COLORTERM")
    (fwd-env "LANG")
    (fwd-env "CLAUDE_CONFIG_DIR")
  ];

  instances = {
    claude = {
      pkg = pkgs.claude-code;
      secret = "mathieu/CLAUDE_CODE_OAUTH_TOKEN";
      jailOptions = [ ];
    };

    claude-perso = {
      pkg = pkgs.claude-code;
      secret = "mathieu/CLAUDE_CODE_OAUTH_TOKEN";
      jailOptions = [ ];
    };
  };

  mkJailedClaude = name: { pkg, secret, jailOptions ? [ ] }:
    let
      secretPath = osConfig.sops.secrets.${secret}.path;
      wrapped = slib.wrapSecrets {
        inherit pkg;
        secrets.CLAUDE_CODE_OAUTH_TOKEN = secretPath;
      };
    in
    lib.hiPrio (jail name wrapped (
      commonJailOptions
      ++ [ (jail.combinators.readonly (jail.combinators.noescape secretPath)) ]
      ++ jailOptions
    ));

  claude-native =
    let
      wrapped = slib.wrapSecrets {
        pkg = pkgs.claude-code;
        secrets.CLAUDE_CODE_OAUTH_TOKEN = osConfig.sops.secrets."mathieu/CLAUDE_CODE_OAUTH_TOKEN".path;
      };
    in
    pkgs.writeShellScriptBin "claude-native" ''
      exec ${wrapped}/bin/${pkgs.claude-code.meta.mainProgram} "$@"
    '';
in
{
  home.sessionVariables.CLAUDE_CONFIG_DIR = "${home}/.claude";

  home.packages = lib.mapAttrsToList mkJailedClaude instances ++ [ claude-native pkgs.rtk ];
}
