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
  version = "0.10.0";

  useFetchCargoVendor = true;

  nativeBuildInputs = with pkgs; [
    git
  ];

  src = fetchTarball {
    url = "https://github.com/Saghen/blink.cmp/archive/refs/tags/v${version}.tar.gz";
    sha256 = "1jzffgfigbl2vpm11dkb794ncxnfbn0yj8nbac1alxf0wzhwiw9i";
  };

  cargoHash = "sha256-ISCrUaIWNn+SfNzrAXKqeBbQyEnuqs3F8GAEl90kK7I=";

  meta = with lib; {
    description = "SIMD fuzzy completion for neovim";
    homepage = "https://github.com/Saghen/blink.cmp";
    license = licenses.mit;
    mainProgram = pname;
  };
}
