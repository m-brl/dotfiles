{ config, pkgs, ... }:

{
  services = {
    thinkfan = {
      enable = true;
      smartSupport = true;
    };
    dbus.packages = [ pkgs.pass-secret-service ];

    gvfs.enable = true;
    protonmail-bridge.enable = true;
    printing = {
      enable = true;
      drivers = [ pkgs.epson-escpr2 ];
    };

    displayManager.sddm = {
      enable = true;
      wayland.enable = true;
    };

    pcscd.enable = true;
    flatpak.enable = true;

    gnome.gnome-keyring.enable = false;

    blueman.enable = true;

    xserver = {
      enable = true;
      videoDrivers = [ "nvidia" ];
      xkb.layout = "us";
      xkb.variant = "altgr-intl";
    };

    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
    };

    udev = {
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

    power-profiles-daemon.enable = false;
    tlp = {
      enable = true;
      settings = {
        START_CHARGE_THRESH_BAT0 = 75;
        STOP_CHARGE_THRESH_BAT0 = 81;
      };
    };

    tailscale = {
      enable = true;
    };

    qbittorrent = {
      enable = false;
    };

    cron = {
      enable = true;
      systemCronJobs = [
      ];
    };

    fprintd.enable = true;


    upower = {
      enable = true;
    };
  };
}
