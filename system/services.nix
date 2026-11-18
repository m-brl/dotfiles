{ lib, pkgs, ... }:

{
  security.sudo.execWheelOnly = true;

  services = {
    tailscale = {
      enable = true;
    };

    openssh = {
      enable = true;
      openFirewall = false;
      settings = {
        PermitRootLogin = "no";
        PasswordAuthentication = false;
      };
    };

    dbus.packages = [ pkgs.pass-secret-service ];

    gvfs.enable = true;

    printing = {
      enable = true;
      drivers = [ pkgs.epson-escpr2 ];
    };

    gnome.gnome-keyring.enable = lib.mkForce false;

    blueman.enable = true;

    xserver = {
      enable = true;
      xkb.layout = "us";
      xkb.variant = "altgr-intl";
      videoDrivers = [ "nvidia" ];
    };

    ollama = {
      enable = false;
      package = pkgs.ollama-cuda;
      loadModels = [
        "mxbai-embed-large"
      ];
    };

    vnstat.enable = true;

    tor = {
      enable = true;
      settings = {
        SOCKSPort = 9050;
      };
    };

    pcscd.enable = true;

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

    cron = {
      enable = true;
      systemCronJobs = [
      ];
    };

    fprintd.enable = true;

    # Firmware updates (BIOS, Thunderbolt, fingerprint reader...) from LVFS.
    fwupd.enable = true;

    # All subvolumes live on the same btrfs filesystem: scrubbing one mount point
    # scrubs the whole device, so only list one to avoid redundant runs.
    btrfs.autoScrub = {
      enable = true;
      interval = "monthly";
      fileSystems = [ "/persist" ];
    };
  };

  programs.yubikey-manager.enable = true;

  boot.kernel.sysctl = {
    "fs.inotify.max_user_watches" = 524288;
    "fs.inotify.max_user_instances" = 8192;
  };
}
