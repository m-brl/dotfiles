{ config, pkgs, ... }:

{
  virtualisation = {
    podman = {
      enable = true;
    };

    libvirtd = {
      enable = true;
      qemu = {
        package = pkgs.qemu_kvm;
        runAsRoot = true;
      };
    };
  };

}
