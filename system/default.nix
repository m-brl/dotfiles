{ config, pkgs, inputs, ... }:

{
  imports = [
    ./boot.nix
    ./hardware.nix
    ./hardware-configuration.nix
    ./network.nix
    ./programs.nix
    ./security.nix
    ./services.nix
    ./users.nix
    ./virtualisation.nix
  ];

  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.allowUnfreePredicate = _: true;
  nixpkgs.overlays = [
    inputs.emacs-overlay.overlay
    inputs.nix-openclaw.overlays.default
  ];
  nixpkgs.config.permittedInsecurePackages = [
    "openclaw-2026.6.33"
  ];

  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.backupFileExtension = "nixbak";
  home-manager.users.mathieu = import ../home;
  home-manager.extraSpecialArgs = { inherit inputs; };
  
  system.stateVersion = "25.11";
  time.timeZone = "Europe/Paris";

  i18n.defaultLocale = "en_US.UTF-8";
  console.keyMap = "us";


  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
    trusted-users = [ "root" "mathieu" ];
  };

  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    ibm-plex orbitron
  ];

  environment.sessionVariables = {
    LIBVA_DRIVER_NAME = "nvidia";
    GDM_BACKEND = "nvidia-drm";
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";
    __NV_PRIME_RENDER_OFFLOAD = "1";
    NVD_BACKEND = "direct";
    WLR_NO_HARDWARE_CURSORS = "1";
  };

  environment.systemPackages = with pkgs; [
    jq
    tzdata
    vim
    (btop.override { cudaSupport = true; })
    which
    ntfs3g
    grim slurp
    xhost
    usbutils
    libmbim

    yubikey-manager yubikey-personalization
    swtpm
    vnstat
    cron
    wireguard-tools libnatpmp
  ];
}
