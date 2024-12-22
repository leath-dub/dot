{ config, pkgs, rustToolchain, ... }:

let
  xdg = config.lib.file.mkOutOfStoreSymlink "/home/cathalo/dot/xdg";
  frizbee = pkgs.callPackage ./deriv/frizbee.nix { inherit rustToolchain; };
  himitsu-ssh = pkgs.callPackage ./deriv/himitsu-ssh.nix {};
  ctags-lsp = pkgs.callPackage ./deriv/ctags-lsp.nix {};
in {
  home.username = "cathalo";
  home.homeDirectory = "/home/cathalo";

  home.stateVersion = "24.11";

  home.packages = with pkgs; [
    neovim
    ripgrep
    fd
    himitsu
    hare
    harec
    haredoc
    emscripten

    lua-language-server
    deno
    universal-ctags
  ] ++ [ frizbee himitsu-ssh ctags-lsp ];

  programs.git = {
    enable = true;
    userName = "leath-dub";
    userEmail = "fierceinbattle@gmail.com";
  };

  xdg.configFile = {
    nvim.source = "${xdg}/nvim";
  };

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  programs.home-manager.enable = true;
}
