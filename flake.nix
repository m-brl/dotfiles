{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    nixpkgs-python.url = "github:nixos/nixpkgs/80d901ec0377e19ac3f7bb8c035201e2e098cc97";
    #nixpkgs-hyprland.url = "github:nixos/nixpkgs/80d901ec0377e19ac3f7bb8c035201e2e098cc97";
    hyprland.url = "github:hyprwm/Hyprland/v0.54.2";
    pass-otp.url = "github:tadfisher/pass-otp/7bb50dbc4b6073f12f40be66a5ee371b9652a646";
    tree-sitter.url = "github:tree-sitter/tree-sitter/v0.26.8";
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs: {
    nixosConfigurations.mborel = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = { inherit inputs; }; 
      modules = [
        ./configuration.nix

	    home-manager.nixosModules.home-manager {
	      home-manager.useGlobalPkgs = true;
	      home-manager.useUserPackages = true;

	      home-manager.users.mat = import ./home.nix;

	      home-manager.extraSpecialArgs = { inherit inputs; };
	    }
      ];
    };
  };
}
