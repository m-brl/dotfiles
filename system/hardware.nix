{ config, pkgs, ... }:

{
  hardware = {
    bluetooth = {
      enable = true;
      powerOnBoot = true;
    };

    graphics = {
      enable = true;
      enable32Bit = true;
      extraPackages = with pkgs; [
        nvidia-vaapi-driver # Traduit VA-API vers NVDEC (essentiel pour Firefox/Chrome)
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
