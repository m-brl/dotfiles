{ config, pkgs, ... }:

{
  users.users.mathieu = {
    isNormalUser = true;
    home = "/home/mathieu";
    shell = pkgs.zsh;

    extraGroups = [
      "wheel"
      "networkmanager"
      "video"
      "audio"
      "libvirtd"
      "docker"
    ];
  };
}
