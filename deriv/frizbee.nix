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
  version = "0.13.1";

  useFetchCargoVendor = true;

  nativeBuildInputs = with pkgs; [
    git
  ];

  src = fetchTarball {
    url = "https://github.com/Saghen/blink.cmp/archive/refs/tags/v${version}.tar.gz";
    sha256 = "1y5p7i6g884r65mhfsazx28g0qs37hc57jm37i7kch9kcf8m7sbq";
  };

  cargoHash = "sha256-F1wh/TjYoiIbDY3J/prVF367MKk3vwM7LqOpRobOs7I=";

  meta = with lib; {
    description = "SIMD fuzzy completion for neovim";
    homepage = "https://github.com/Saghen/blink.cmp";
    license = licenses.mit;
    mainProgram = pname;
  };
}
