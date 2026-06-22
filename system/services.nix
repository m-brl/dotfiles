{ config, pkgs, ... }:

{
  services.thinkfan = {
    enable = true;
    smartSupport = true;
    levels = [
      [0 0 53]
      [1 48 60]
      [3 55 70]
      [5 65 80]
      [7 75 85]
      ["level auto" 80 200]
    ];
  };

  services.gvfs.enable = true;
  services.protonmail-bridge.enable = true;
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
    theme = "catppuccin-mocha-peach";
    package = pkgs.kdePackages.sddm;
  };
  services.pcscd.enable = true;
  services.flatpak.enable = true;

  services.gnome.gnome-keyring.enable = true;

  services.blueman.enable = true;

  services.xserver = {
    enable = true;
    videoDrivers = [ "nvidia" ];
    xkb.layout = "us";
    xkb.variant = "altgr-intl";
  };

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  services.udev = {
    enable = true;
    extraRules = ''
      KERNEL=="hidraw*", SUBSYSTEM=="hidraw", ATTRS{idVendor}=="3434",  MODE="0660", GROUP="users", TAG+="uaccess"
    '';
    packages = [
      pkgs.yubikey-personalization
      pkgs.libu2f-host
      pkgs.libfido2
    ];
  };

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

  services.qbittorrent = {
    enable = false;
  };
}
