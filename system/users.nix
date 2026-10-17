{ config, pkgs, ... }:

{
  users.mutableUsers = false;
  users.users.mathieu = {
    isNormalUser = true;
    createHome = true;
    home = "/home/mathieu";
    shell = pkgs.zsh;
    hashedPasswordFile = config.sops.secrets."mathieu-password".path;

    extraGroups = [
      "wheel"
      "dialout"
      "networkmanager"
      "video"
      "audio"
      "libvirtd"
      "input"
      "lpadmin"
    ];
  };
}
