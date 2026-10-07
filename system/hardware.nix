{ config, pkgs, ... }:

{
  hardware = {
    enableAllHardware = true;
    enableAllFirmware = true;
    sensor.iio.enable = true;
    bluetooth = {
      enable = true;
      powerOnBoot = true;
    };

    graphics = {
      enable = true;
      enable32Bit = true;
      extraPackages = with pkgs; [
        nvidia-vaapi-driver
      ];
    };

    nvidia = {
      modesetting.enable = true;
      powerManagement.enable = true;
      powerManagement.finegrained = false;
      open = false;

      nvidiaSettings = true;
    };

    nvidia-container-toolkit = {
      enable = true;
    };
    logitech.wireless.enable = true;
  };
}
