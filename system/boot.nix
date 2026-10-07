{ config, pkgs, lib, ... }:

{
  boot = {
    initrd = {
      systemd.enable = true;
      supportedFilesystems = [ "btrfs" ];

      availableKernelModules = [ "xhci_pci" "nvme" "thunderbolt" "usbhid" "usb_storage" "sd_mod" "rtsx_pci_sdmmc" ];

      luks.devices."crypted".device = "/dev/disk/by-uuid/d3e43a99-e6ef-45eb-b407-71253cb54203";
    };

    kernelModules = [
      "kvm_intel"
      "thinkpad_acpi"
      "v4l2loopback"
    ];

    kernelParams = [
      "resume_offset=64391447"
    ];

    extraModulePackages = [ config.boot.kernelPackages.v4l2loopback ];

    extraModprobeConfig = ''
      options thinkpad_acpi fan_control=1
      options v4l2loopback devices=1 video_nr=10 card_label="OBS Virtual Cam" exclusive_caps=1
    '';

    resumeDevice = "/dev/mapper/crypted";

    loader = {
      systemd-boot.enable = lib.mkForce false;
      efi.canTouchEfiVariables = true;
    };

    lanzaboote = {
      enable = true;
      pkiBundle = "/var/lib/sbctl";
      configurationLimit = 5;
    };

    tmp.useTmpfs = true;
    kernelPackages = pkgs.linuxPackages_latest;
    kernel.sysctl = {
      "fs.inotify.max_user_watches" = 524288;
      "fs.inotify.max_user_instances" = 8192;
    };

  };
}
