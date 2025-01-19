{ inputs, config, pkgs, system, ... }:

let
  xdg = config.lib.file.mkOutOfStoreSymlink "/home/cathalo/dot/xdg";
  frizbee = pkgs.callPackage ./deriv/frizbee.nix {
    rustToolchain = inputs.fenix.packages.${system}.minimal.toolchain;
  };
  himitsu-ssh = pkgs.callPackage ./deriv/himitsu-ssh.nix {};
  ctags-lsp = pkgs.callPackage ./deriv/ctags-lsp.nix {};
  ghostty = inputs.ghostty.packages.${system}.default;
in {
  home.username = "cathalo";
  home.homeDirectory = "/home/cathalo";

  home.stateVersion = "24.11";

  home.packages = with pkgs; [
    ripgrep
    fd
    jq
    himitsu
    tealdeer
    dust
    hare
    harec
    haredoc
    love

    meson
    ninja
    muon
    samurai

    clang-tools
    lua-language-server
    svelte-language-server
    deno
    universal-ctags
    # emscripten

    nixgl.nixGLIntel
    slic3r
  ] ++ [ ghostty frizbee himitsu-ssh ctags-lsp ];

  programs.git = {
    enable = true;
    userName = "leath-dub";
    userEmail = "fierceinbattle@gmail.com";
  };

  programs.neovim = {
    enable = true;
    package = inputs.neovim-nightly-overlay.packages.${pkgs.system}.default;
  };

  xdg.configFile = {
    nvim.source = "${xdg}/nvim";
  };

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  programs.home-manager.enable = true;
}
