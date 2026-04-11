# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ inputs, config, lib, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ];

# Use the systemd-boot EFI boot loader.
  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.loader.systemd-boot.enable = true;
  boot.loader.systemd-boot.configurationLimit = 3;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.supportedFilesystems = [ "lvm" ];

  security.polkit.enable = true;
  services.gnome.gnome-keyring.enable = true;
  security.pam.services.sddm.enableGnomeKeyring = true;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  networking.hostName = "mborel"; # Define your hostname.

# Configure network connections interactively with nmcli or nmtui.
  networking.networkmanager.enable = true;

# Set your time zone.
  time.timeZone = "America/Toronto";

# Configure network proxy if necessary
# networking.proxy.default = "http://user:password@proxy:port/";
# networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  networking.networkmanager.ensureProfiles.profiles = {
  };

# Select internationalisation properties.
# i18n.defaultLocale = "en_US.UTF-8";
# console = {
#   font = "Lat2-Terminus16";
#   keyMap = "us";
#   useXkbConfig = true; # use xkb.options in tty.
# };

# Enable the X11 windowing system.
  services.xserver.enable = true;

  services.udev = {
    enable = true;
    extraRules = ''
      KERNEL=="hidraw*", SUBSYSTEM=="hidraw", ATTRS{idVendor}=="3434",  MODE="0660", GROUP="users", TAG+="uaccess"
    '';
  };

# Enable the GNOME Desktop Environment.
  #services.displayManager.gdm.enable = true;
  services.displayManager.sddm.enable = true;
#  services.desktopManager.gnome.enable = true;
#
#  services.greetd = {
#    enable = true;
#    settings = {
#      default_session = {
#        command = "${pkgs.greetd}/bin/agreety --cmd hyprland";
#      };
#    };
#  };


# Configure keymap in X11
# services.xserver.xkb.layout = "us";
# services.xserver.xkb.options = "eurosign:e,caps:escape";

# Enable CUPS to print documents.
# services.printing.enable = true;

# Enable sound.
  services.pulseaudio.enable = false;
# OR
  services.pipewire = {
    enable = true;
    pulse.enable = true;
    alsa.enable = true;
  };

  services.blueman.enable = true;

# Enable touchpad support (enabled default in most desktopManager).
# services.libinput.enable = true;

# Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.mat = {
    isNormalUser = true;
    home = "/home/mat";
    extraGroups = [ "wheel" "libvirtd" ];
    shell = pkgs.zsh;
    packages = with pkgs; [
    ];
  };

  xdg.portal = {
    enable = true;
    extraPortals = [ 
      #inputs.nixpkgs-hyprland.legacyPackages.${pkgs.system}.xdg-desktop-portal-hyprland
      #inputs.nixpkgs-hyprland.legacyPackages.${pkgs.system}.xdg-desktop-portal-gtk
    ];
    config = {
      common = {
	default = [
	  "gtk"
	];
      };
      hyprland = {
	default = [
	  "hyprland" "gtk"
	];
      };
    };
  };

# programs.firefox.enable = true;

  nixpkgs.config.allowUnfree = true;
# List packages installed in system profile.
# You can use https://search.nixos.org/ to find more packages (and options).
  environment.systemPackages = with pkgs; [
    gcc clang cmake pkg-config gnumake ninja cgdb gdb valgrind direnv nix-direnv
    kitty docker man-pages quickshell
    jetbrains.clion jetbrains.idea jetbrains.pycharm jetbrains.mps
    git nix-index
    librewolf brave chromium libreoffice
    ntfs3g
    swtpm
    libnotify
    pulseaudio easyeffects qpwgraph lsp-plugins
    wineWow64Packages.waylandFull
    protonup-qt
    patchelf vnstat

    hyprlauncher hyprlock hypridle mpvpaper
    rclone rsync cron
    xdg-desktop-portal-gtk
    wofi wl-clipboard cliphist
    playerctl brightnessctl
    grim slurp
    zip unzip ripgrep which
    pass #inputs.pass-otp.packages.${pkgs.stdenv.hostPlatform.system}.pass-otp
    discord thunderbird steam
    pavucontrol
    inputs.nixpkgs-python.legacyPackages.${pkgs.stdenv.hostPlatform.system}.python314
    uv
    (btop.override { cudaSupport = true; })
  ];

  environment.sessionVariables = {
    LV2_PATH = "/run/current-system/sw/lib/lv2";
  };

  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
  ];

# Some programs need SUID wrappers, can be configured further or are
# started in user sessions.
# programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  programs.zsh = {
    enable = true;
  };
  programs.direnv.enable = true;
  programs.hyprland = {
    enable = true;
    withUWSM = true;
    xwayland.enable = true;
    package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
  };
  programs.kdeconnect.enable = true;

# List services that you want to enable:

# Enable the OpenSSH daemon.
  services.flatpak.enable = true;
  services.power-profiles-daemon.enable = false;
  services.tlp = {
    enable = true;
    settings = {
      START_CHARGE_THRESH_BAT0 = 75;
      STOP_CHARGE_THRESH_BAT0 = 81;
    };
  };
  services.tailscale = {
    enable = true;
  };
  services.fprintd.enable = true;
# services.openssh.enable = true;
  services.ollama = {
    enable = true;
    package = pkgs.ollama-cuda;
  };

  virtualisation.libvirtd = {
    enable = true;
  };
  programs.virt-manager.enable = true;


  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };

  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = true;
    powerManagement.finegrained = false;
    open = false;
    nvidiaSettings = true;
  };

# Open ports in the firewall.
# networking.firewall.allowedTCPPorts = [ ... ];
# networking.firewall.allowedUDPPorts = [ ... ];
# Or disable the firewall altogether.
# networking.firewall.enable = false;

# Copy the NixOS configuration file and link it from the resulting system
# (/run/current-system/configuration.nix). This is useful in case you
# accidentally delete configuration.nix.
# system.copySystemConfiguration = true;

# This option defines the first version of NixOS you have installed on this particular machine,
# and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
#
# Most users should NEVER change this value after the initial install, for any reason,
# even if you've upgraded your system to a new NixOS release.
#
# This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
# so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
# to actually do that.
#
# This value being lower than the current NixOS release does NOT mean your system is
# out of date, out of support, or vulnerable.
#
# Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
# and migrated your data accordingly.
#
# For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "25.11"; # Did you read the comment?

}

