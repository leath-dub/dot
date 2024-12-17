{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, flake-utils, home-manager }:
    flake-utils.lib.eachDefaultSystem (system: 
    let pkgs = nixpkgs.legacyPackages.${system}; in rec {
      packages.homeConfigurations."cathalo" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [ ./home.nix ];
      };
      packages.home-manager = home-manager.packages.${system}.default;
      packages.default = packages.home-manager;
    });
}
