{
  description = "Workstation configuration for NixOS";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";

    flake-parts.url = "github:hercules-ci/flake-parts";
    flake-parts.inputs.nixpkgs-lib.follows = "nixpkgs";

    systems.url = "github:nix-systems/default";

    jail-nix.url = "sourcehut:~alexdavid/jail.nix";

    impermanence.url = "github:nix-community/impermanence";
    impermanence.inputs.nixpkgs.follows = "nixpkgs";
    impermanence.inputs.home-manager.follows = "home-manager";

    lanzaboote.url = "github:nix-community/lanzaboote";
    lanzaboote.inputs.nixpkgs.follows = "nixpkgs";

    nixvim.url = "github:nix-community/nixvim";
    nixvim.inputs.nixpkgs.follows = "nixpkgs";
    nixvim.inputs.flake-parts.follows = "flake-parts";
    nixvim.inputs.systems.follows = "systems";

    stylix.url = "github:nix-community/stylix";
    stylix.inputs.nixpkgs.follows = "nixpkgs";
    stylix.inputs.nur.follows = "nur";
    stylix.inputs.flake-parts.follows = "flake-parts";
    stylix.inputs.systems.follows = "systems";

    sops-nix.url = "github:Mic92/sops-nix";
    sops-nix.inputs.nixpkgs.follows = "nixpkgs";

    nix-index-database.url = "github:nix-community/nix-index-database";
    nix-index-database.inputs.nixpkgs.follows = "nixpkgs";

    image-collection.url = "github:ItsTerm1n4l/Wallpapers";
    image-collection.flake = false;

    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    nur.url = "github:nix-community/NUR";
    nur.inputs.nixpkgs.follows = "nixpkgs";
    nur.inputs.flake-parts.follows = "flake-parts";

    nixos-hardware.url = "github:m-brl/nixos-hardware";
    nixos-hardware.inputs.nixpkgs.follows = "nixpkgs";

    secrets.url = "git+ssh://git@github.com/m-brl/secrets";
    secrets.flake = false;

    sonyd.url = "github:m-brl/sonyd";
    sonyd.inputs.nixpkgs.follows = "nixpkgs";

    logid.url = "github:m-brl/logid";
    logid.inputs.nixpkgs.follows = "nixpkgs";

    quickshell-bar.url = "github:m-brl/quickshell-bar/master";
    quickshell-bar.flake = false;
  };

  outputs = { nixpkgs, ... }@inputs: {
    nixosConfigurations.mathieu-workstation = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = { inherit inputs; };
      modules = [ ./system ];
    };
  };
}
