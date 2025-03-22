{ inputs, config, pkgs, system, ... }:

let
  xdg = config.lib.file.mkOutOfStoreSymlink "/home/cathalo/dot/xdg";
  homeDir = config.lib.file.mkOutOfStoreSymlink "/home/cathalo/dot/home";
  frizbee = pkgs.callPackage ./deriv/frizbee.nix {
    rustToolchain = inputs.fenix.packages.${system}.minimal.toolchain;
  };
  himitsu-ssh = pkgs.callPackage ./deriv/himitsu-ssh.nix {};
  ctags-lsp = pkgs.callPackage ./deriv/ctags-lsp.nix {};
  # ghostty = inputs.ghostty.packages.${system}.default;
in {
  home.username = "cathalo";
  home.homeDirectory = "/home/cathalo";

  home.stateVersion = "24.11";

  home.packages = with pkgs; [
    ripgrep
    eza
    zoxide
    fd
    jq
    yq
    himitsu
    tealdeer
    dust
    btop
    hare
    harec
    haredoc
    yash

    meson
    ninja
    muon
    samurai
    zig
    emscripten
    just
    nq

    glab
    rsync

    # LSP
    clang-tools
    lua-language-server
    svelte-language-server
    deno
    universal-ctags
    zls
    python312Packages.python-lsp-server
    rust-analyzer
    jdt-language-server
    harper
    # emscripten

    # DAP
    vscode-js-debug

    nixgl.nixGLIntel
    # slic3r
  ] ++ [ ghostty frizbee himitsu-ssh ctags-lsp ];

  programs.git = {
    enable = true;
    userName = "leath-dub";
    userEmail = "fierceinbattle@gmail.com";
    extraConfig = {
      commit.gpgsign = true;
      gpg.format = "ssh";
      user.signingKey = "~/.ssh/soc_gitlab.pub";
    };
  };

  programs.neovim = {
    enable = true;
    package = inputs.neovim-nightly-overlay.packages.${pkgs.system}.default;
  };

  xdg.configFile = {
    nvim.source = "${xdg}/nvim";
    sway.source = "${xdg}/sway";
    foot.source = "${xdg}/foot";
  };

  home.file = {
    ".yashrc".source = "${homeDir}/yashrc";
  };

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  programs.home-manager.enable = true;
}
