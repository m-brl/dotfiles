{ config, pkgs, inputs, ... }:

let
  slib = import ../../lib { inherit pkgs; };
in
{
  _module.args.slib = slib;

  imports = [
    ./stylix.nix
    ./sops.nix
    ./programs.nix
    ./users.nix
  ];

  nixpkgs = {
    config.allowUnfree = true;
    overlays = [
      inputs.nix-openclaw.overlays.default
    ];
    config.permittedInsecurePackages = [
      "openclaw-2026.6.33"
    ];
  };

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = "nixbak";
    extraSpecialArgs = { inherit inputs slib; };
  };
  
  system.stateVersion = "25.11";
  time.timeZone = "Europe/Paris";

  i18n.defaultLocale = "en_US.UTF-8";
  console.keyMap = "us";

  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
    trusted-users = [ "root" ];
  };

  environment.sessionVariables = {
    CLAUDE_CONFIG_DIR = "${config.users.users.mathieu.home}/.claude";
  };

  environment.systemPackages = with pkgs; [
    jq
    tzdata
    vim
    which
    sops
  ];
}
