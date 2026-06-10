{ config, pkgs, ... }:

{
  virtualisation = {
    docker = {
      enable = true;
      enableOnBoot = true;
    };

    libvirtd = {
      enable = true;
      qemu = {
        package = pkgs.qemu_kvm;
        runAsRoot = true;
      };
    };

    waydroid = {
      enable = true;
      package = pkgs.waydroid-nftables;
    };
  };

}
