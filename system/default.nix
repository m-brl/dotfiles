{ pkgs, inputs, ... }:

let
  slib = import ../lib { inherit pkgs; };
in
{
  imports = [
    inputs.stylix.nixosModules.stylix
    inputs.sops-nix.nixosModules.sops
    inputs.home-manager.nixosModules.home-manager
    inputs.nur.modules.nixos.default
    inputs.impermanence.nixosModules.impermanence
    inputs.lanzaboote.nixosModules.lanzaboote
    ./hardware-configuration.nix
    ./boot.nix
    ./desktop.nix
    ./hardware.nix
    ./network.nix
    ./nix.nix
    ./persistence.nix
    ./power.nix
    ./programs.nix
    ./security.nix
    ./services.nix
    ./sops.nix
    ./stylix.nix
    ./usbguard.nix
    ./users.nix
    ./virtualisation.nix
  ];

  networking.hostName = "mathieu-workstation";

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = "nixbak";
    extraSpecialArgs = { inherit inputs slib; };
    users.mathieu.imports = [ ../home ];
  };

  nixpkgs.overlays = [
    inputs.logid.overlays.default
    inputs.sonyd.overlays.default
  ];

  system.stateVersion = "25.11";
  time.timeZone = "Europe/Paris";

  i18n.defaultLocale = "en_US.UTF-8";
  console.keyMap = "us";

  environment.sessionVariables = {
    AQ_DRM_DEVICES = "/dev/dri/intel-igpu:/dev/dri/nvidia-dgpu";
    NVD_BACKEND = "direct";
    WLR_NO_HARDWARE_CURSORS = "1";
  };

  environment.systemPackages = with pkgs; [
    jq
    tzdata
    vim
    which
    sops

    grim slurp
    xhost
    pulseaudio

    lm_sensors
    ntfs3g
    usbutils
    libmbim

    yubikey-manager yubikey-personalization
    sbctl
    swtpm
    wireguard-tools libnatpmp
  ];

  fonts.packages = [ pkgs.orbitron ];
}
