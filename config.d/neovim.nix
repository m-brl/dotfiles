{ config, inputs, pkgs, ... }:

let
  pkgsOverlay = import pkgs.path {
    inherit (pkgs) system;
    overlays = [ inputs.neovim-nightly-overlay.overlays.default ];
  };

  neovim = pkgs.symlinkJoin {
    name = "nvim-wrappped";
    paths = [ pkgsOverlay.neovim ];
    nativeBuildInputs = [ pkgs.makeWrapper ];
    postBuild = ''
      wrapProgram $out/bin/nvim \
      --prefix PATH : ${pkgs.lib.makeBinPath [
        inputs.tree-sitter.packages.${pkgs.stdenv.hostPlatform.system}.default
        pkgs.nodejs_24
        pkgs.clang-tools pkgs.llvmPackages_20.clang-tools
        pkgs.jdt-language-server
        pkgs.pyright
      ]}
      ln -s ${pkgs.tree-sitter}/bin/tree-sitter $out/bin/tree-sitter-cli
    '';
  };
in
  {
    home.packages = [
      neovim
    ];

    xdg.configFile.nvim = {
      enable = true;
      source = ./nvim;
      recursive = true;
    };
  }

