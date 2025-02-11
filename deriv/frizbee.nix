{
  lib,
  pkgs,
  rustToolchain,
  fetchFromGitHub,
}:

let
  rustPlatform = pkgs.makeRustPlatform {
    cargo = rustToolchain;
    rustc = rustToolchain;
  };
in rustPlatform.buildRustPackage rec {
  pname = "blink-cmp-fuzzy";
  version = "0.11.0";

  useFetchCargoVendor = true;

  nativeBuildInputs = with pkgs; [
    git
  ];

  src = fetchTarball {
    url = "https://github.com/Saghen/blink.cmp/archive/refs/tags/v${version}.tar.gz";
    sha256 = "1j3sj03i72iw5npwwksc7w7axv8z0nbgi11adkfng9ak73kn1gdq";
  };

  cargoHash = "sha256-EoxKmVyJRxqI6HOuuiSj5+IOuo5M8ZNdSyk86sQNtE8=";

  meta = with lib; {
    description = "SIMD fuzzy completion for neovim";
    homepage = "https://github.com/Saghen/blink.cmp";
    license = licenses.mit;
    mainProgram = pname;
  };
}
