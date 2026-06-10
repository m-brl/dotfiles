{ lib, config, pkgs, inputs, ... }:

{
  imports = [
    inputs.nixvim.homeModules.nixvim
    ./neovim-plugins.nix
  ];

  programs.nixvim = {
    enable = true;

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

    keymaps = [
      {
        mode = "n";
        key = "<F7>";
        action = "<C-o>";
        options = {
          desc = "Jump backward";
        };
      }
      {
        mode = "n";
        key = "<F8>";
        action = config.lib.nixvim.utils.mkRaw "vim.lsp.buf.definition";
        options = {
          desc = "LSP Go to Definition";
        };
      }
      {
        mode = "n";
        key = "<F9>";
        action = "<C-i>";
        options = {
          desc = "Jump forward";
        };
      }
    ];

    opts = {
      laststatus = 3;

      number = true;
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
