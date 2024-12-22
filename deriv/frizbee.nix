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
  version = "0.8.1";

  useFetchCargoVendor = true;

  src = fetchTarball {
    url = "https://github.com/Saghen/blink.cmp/archive/refs/tags/v0.8.1.tar.gz";
    sha256 = "0dh41pgkvjhm7adjlgv42zxdgg1d0gmv6q51qda4f25xsnvzap46";
  };

  cargoHash = "sha256-t84hokb2loZ6FPPt4eN8HzgNQJrQUdiG5//ZbmlasWY=";

  meta = with lib; {
    description = "SIMD fuzzy completion for neovim";
    homepage = "https://github.com/Saghen/blink.cmp";
    license = licenses.mit;
    mainProgram = "blink-cmp-fuzzy";
  };
}
