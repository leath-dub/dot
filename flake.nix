{
  description = "A very basic flake";

  inputs = {
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";

    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    fenix = {
      url = "github:nix-community/fenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    ghostty.url = "github:ghostty-org/ghostty";
    nixgl.url = "github:nix-community/nixGL";
  };

  outputs = { self, nixpkgs, flake-utils, home-manager, ... }@inputs:
    flake-utils.lib.eachDefaultSystem (system: 
    let
      pkgs = nixpkgs.legacyPackages.${system} // {
        overlays = [ inputs.nixgl.overlay ];
      };
    in rec {
      packages.homeConfigurations."cathalo" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [ ./home.nix ];
        extraSpecialArgs = {
          inherit inputs;
          inherit system;
        };
      };
      packages.home-manager = home-manager.packages.${system}.default;
      packages.default = packages.home-manager;
    });
}
