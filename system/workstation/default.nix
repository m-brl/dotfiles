{ pkgs, ... }:

{
  imports = [
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

  sops.age.keyFile = "/persist/var/lib/sops-nix/keys.txt";

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
    ntfs3g
    grim slurp
    xhost
    usbutils
    libmbim
    pulseaudio

    yubikey-manager yubikey-personalization
    sbctl
    swtpm
    wireguard-tools libnatpmp
  ];

  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    ibm-plex orbitron
  ];
}
