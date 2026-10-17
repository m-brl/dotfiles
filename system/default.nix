{ config, pkgs, inputs, ... }:

let
  slib = import ../lib { inherit pkgs; };
in
{
  _module.args.slib = slib;

  imports = [
    ./stylix.nix
    ./boot.nix
    ./hardware.nix
    ./hardware-configuration.nix
    ./network.nix
    ./persistence.nix
    ./programs.nix
    ./security.nix
    ./services.nix
    ./users.nix
    ./virtualisation.nix
  ];

  nixpkgs = {
    config.allowUnfree = true;
    config.allowUnfreePredicate = _: true;
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
    users.mathieu = import ../home;
    extraSpecialArgs = { inherit inputs slib; };
  };
  
  system.stateVersion = "25.11";
  time.timeZone = "Europe/Paris";

  i18n.defaultLocale = "en_US.UTF-8";
  console.keyMap = "us";

  sops = {
    defaultSopsFile = ../secrets/secrets.json;
    defaultSopsFormat = "json";
    age.keyFile = "/persist/var/lib/sops-nix/keys.txt";

    secrets = {
      "mathieu-password".neededForUsers = true;
      "CLAUDE_CODE_OAUTH_TOKEN" = { owner = "mathieu"; mode = "0400"; };
      "GH_TOKEN" = { owner = "mathieu"; mode = "0400"; };
    };
  };

  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
    trusted-users = [ "root" "mathieu" ];
  };

  environment.sessionVariables = {
    LIBVA_DRIVER_NAME = "nvidia";
    GBM_BACKEND = "nvidia-drm";
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";
    __NV_PRIME_RENDER_OFFLOAD = "1";
    NVD_BACKEND = "direct";
    WLR_NO_HARDWARE_CURSORS = "1";
  };

  environment.systemPackages = with pkgs; [
    lm_sensors
    jq
    tzdata
    vim
    which
    ntfs3g
    grim slurp
    xhost
    usbutils
    libmbim
    pulseaudio

    yubikey-manager yubikey-personalization
    sbctl
    swtpm
    cron
    wireguard-tools libnatpmp
  ];

  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    ibm-plex orbitron
  ];
}
