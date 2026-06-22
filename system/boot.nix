{ config, pkgs, ... }:

{
  boot = {
    loader = {
      systemd-boot = {
        enable = true;
        configurationLimit = 5;
      };
      efi.canTouchEfiVariables = true;
    };
    kernelPackages = pkgs.linuxPackages_latest;
    supportedFilesystems = [ "lvm" ];
    kernel.sysctl = {
      "fs.inotify.max_user_watches" = 524288;
    };
    extraModprobeConfig = ''
        options thinkpad_acpi fan_control=1
    '';
  };
}
