{
  lib,
  buildGoModule,
  fetchFromGitHub,
  pkgs,
}:

buildGoModule rec {
  pname = "ctags-lsp";
  version = "0.6.1";

  src = fetchFromGitHub {
    owner = "netmute";
    repo = pname;
    rev = "refs/tags/v${version}";
    hash = "sha256-wSccfhVp1PDn/gj46r8BNskEuBuRIx1wydYAW1PV4cg=";
  };

  vendorHash = null;
  # subPackages = [ "." ];

  ldflags = [
    "-X main.version=${version}"
    "-X main.buildSource=nix"
  ];

  nativeBuildInputs = [ pkgs.git ];

  meta = {
    description = "LSP implementation using universal-ctags as backend";
    homepage = "https://github.com/netmute/ctags-lsp";
    license = lib.licenses.mit;
    mainProgram = "ctags-lsp";
  };
}

