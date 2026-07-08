{ config, pkgs, ... }:

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
  
  system.stateVersion = "25.11";
  time.timeZone = "Europe/Paris";

  i18n.defaultLocale = "en_US.UTF-8";
  console.keyMap = "us";

  nixpkgs.config.allowUnfree = true;

  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
    trusted-users = [ "root" "mathieu" ];
  };

  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
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
    tzdata
    vim
    (btop.override { cudaSupport = true; })
    which
    ntfs3g
    grim slurp
    xhost

    yubikey-manager yubikey-personalization
    swtpm
    vnstat
    cron
    wireguard-tools libnatpmp
  ];
}
