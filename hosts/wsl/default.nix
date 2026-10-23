{ inputs, ... }:

{
  imports = [
    ../../system/common
    inputs.nixos-wsl.nixosModules.default
  ];

  wsl = {
    enable = true;
    defaultUser = "mathieu";
  };

  networking.hostName = "mathieu-wsl";

  home-manager.users.mathieu = import ../../home/wsl.nix;
}
