{ config, pkgs, ... }:

{
  boot = {
    initrd = {
      systemd.enable = true;
      supportedFilesystems = [ "btrfs" ];
      kernelModules = [ 
        "nvidia" "nvidia_modeset" "nvidia_uvm" "nvidia_drm"
      ];
    };

    kernelModules = [
      "intel_ish_ipc" "intel_ishtp" "intel_ishtp_hid" "industrialio"
      "thinkpad_acpi"
      "v4l2loopback"
    ];

    kernelParams = [
      "resume_offset=64391447"
    ];

    extraModprobeConfig = ''
      options thinkpad_acpi fan_control=1
      options v4l2loopback devices=1 video_nr=10 card_label="OBS Virtual Cam" exclusive_caps=1
    '';

    resumeDevice = "/dev/mapper/crypted";

    loader = {
      systemd-boot = {
        enable = true;
        configurationLimit = 5;
      };
      efi.canTouchEfiVariables = true;
    };
    tmp.useTmpfs = true;
    kernelPackages = pkgs.linuxPackages_latest;
    supportedFilesystems = [ "lvm" ];
    kernel.sysctl = {
      "fs.inotify.max_user_watches" = 524288;
      "fs.inotify.max_user_instances" = 8192;
    };

  };
}
