{ config, pkgs, ... }:

{
  users.users.mathieu = {
    isNormalUser = true;
    home = "/home/mathieu";
    shell = pkgs.zsh;

    extraGroups = [
      "wheel"
      "dialout"
      "networkmanager"
      "video"
      "audio"
      "libvirtd"
      "docker"
      "input"
      "lpadmin"
    ];
  };
}
