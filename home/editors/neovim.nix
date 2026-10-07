{ lib, config, pkgs, inputs, ... }:

{
  imports = [
    inputs.nixvim.homeModules.nixvim
    ./neovim-plugins.nix
    ./neovim-bindings.nix
  ];

  programs.nixvim = {
    enable = true;

    nixpkgs.config.allowUnfree = true;

    extraPackages = with pkgs; [
      ruff clang-tools alejandra kdePackages.qtdeclarative
      claude-agent-acp
      cargo rustc rust-analyzer clippy rustfmt
    ];

    diagnostic.settings = {
      virtual_text = {
        prefix = "●";
        source = "always";
      };
      signs = true;
      underline = true;
      update_in_insert = false;
      severity_sort = true;
      float = {
        border = "rounded";
        source = "always";
        header = "";
        prefix = "";
        focusable = false;
      };
    };

    colorschemes = {
      rose-pine.enable = true;
    };

    opts = {
      laststatus = 3;

      number = false;
      relativenumber = false;

      wrap = true;
      showcmd = true;
      termguicolors = true;

      list = true;
      listchars = {
        space = "·";
        tab = "» ";
        eol = "↵";
        extends = "›";
        precedes = "‹";
      };

      clipboard = "unnamedplus";

      colorcolumn = "80";

      expandtab = true;
      shiftwidth = 4;
      tabstop = 4;
      softtabstop = 4;

      foldmethod = "expr";
      foldexpr = "v:lua.vim.treesitter.foldexpr()";
      foldlevel = 99;
    };

    globals = {
      mapleader = " ";

      copilot_no_tab_map = true;
    };

    autoCmd = [
      {
        event = "FileType";
        pattern = [ "nix" "yaml" "lua" ];
        command = "setlocal shiftwidth=2 tabstop=2 softtabstop=2";
      }
    ];

    extraConfigLuaPre = ''
    '';
  };
}
