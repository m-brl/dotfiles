{ inputs, ... }:

{
  imports = [
    ../../system/common
    ../../system/workstation
    inputs.impermanence.nixosModules.impermanence
    inputs.lanzaboote.nixosModules.lanzaboote
    inputs.nix-mineral.nixosModules.nix-mineral
  ];

  home-manager.users.mathieu = import ../../home/workstation.nix;
}
