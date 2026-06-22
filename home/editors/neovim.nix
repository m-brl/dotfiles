{ lib, config, pkgs, inputs, ... }:

{
  imports = [
    inputs.nixvim.homeModules.nixvim
    ./neovim-plugins.nix
    ./neovim-bindings.nix
  ];

  programs.nixvim = {
    enable = true;

    extraPackages = with pkgs; [
      ruff clang-tools alejandra kdePackages.qtdeclarative
    ];

    extraConfigLua = ''
      vim.diagnostic.config({
        virtual_text = {
          source = "always",
          prefix = '●',
        },
        float = {
        source = "always",
        },
        signs = true,
        underline = true,
        update_in_insert = false,
        severity_sort = true,
      })
      '';


    diagnostic = {
      virtual_text = {
        prefix = "●";
        source = "always";
      };
      signs = true;
      underline = true;
      update_in_insert = false;
      severity_sort = true;
    };

    colorschemes.catppuccin = {
      enable = true;
      flavour = "mocha";
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

      #"airline#extensions#tabline#enabled" = 1;
      #"airline#extensions#tabline#fnamemod" = ":t";
      #"airline_powerline_fonts" = 1;
    };
  };
}
