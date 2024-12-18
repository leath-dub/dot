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
in rustPlatform.buildRustPackage {
  pname = "blink-cmp-fuzzy";
  version = "0.7.6";

  useFetchCargoVendor = true;

  src = fetchTarball {
    url = "https://github.com/Saghen/blink.cmp/archives/refs/tags/v0.7.6.tar.gz";
    sha256 = "0kwwf7y16fyqigd9pnm14bj9s5bf48862lyvyn6kmqrild92lc3z";
  };

  cargoHash = "sha256-XXI2jEoD6XbFNk3O8B6+aLzl1ZcJq1VinQXb+AOw8Rw=";

  meta = with lib; {
    description = "SIMD fuzzy completion for neovim";
    homepage = "https://github.com/Saghen/blink.cmp";
    license = licenses.mit;
    mainProgram = "blink-cmp-fuzzy";
  };
}
