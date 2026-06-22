{config, pkgs, inputs, ...}:

{
  programs.nixvim.plugins = {
    lsp = {
      enable = true;
      servers = {
        clangd.enable = true;
        cmake.enable = false;
        neocmake.enable = true;
        pyright.enable = true;
        ruff.enable = true;
        nixd.enable = true;
        qmlls.enable = false;
      };
    };

    web-devicons.enable = true;


    luasnip = {
      enable = true;
      fromVscode = [
        {}
      ];
    };

    lspkind = {
      enable = true;

      settings = {
        mode = "symbol_text";
        preset = "codicons";
        cmp = {
          enable = true;
          menu = {
            nvim_lsp = "[LSP]";
            luasnip = "[Snip]";
            path = "[Path]";
            buffer = "[Buf]";
            vim-dadbod-completion = "[SQL]";
          };
        };
      };
    };

    cmp = {
      enable = true;
      autoEnableSources = true;

      settings = {
        snippet = {
          expand = "function(args) require('luasnip').lsp_expand(args.body) end";
        };

        mapping = {
          "<C-n>" = "cmp.mapping.select_next_item()";
          "<C-p>" = "cmp.mapping.select_prev_item()";
          "<C-Space>" = "cmp.mapping.complete()";
          "<C-e>" = "cmp.mapping.abort()";
          "<CR>" = "cmp.mapping.confirm({ select = true })";
        };

        sources = [
          { name = "nvim_lsp"; }
          { name = "vim-dadbod-completion"; }
          { name = "path"; }
          { name = "buffer"; }
          { name = "luasnip"; }
        ];

        window = {
          completion = {
            border = [ "╭" "─" "╮" "│" "╯" "─" "╰" "│" ];
            winhighlight = "Normal:CmpPmenu,CursorLine:CmpSel,Search:None";
          };
          documentation = {
            border = [ "╭" "─" "╮" "│" "╯" "─" "╰" "│" ];
            winhighlight = "Normal:CmpDoc,FloatBorder:CmpDocBorder";
          };
        };

      };
    };
    cmp-buffer.enable = true;
    cmp-path.enable = true;
    cmp-nvim-lsp.enable = true;

    conform-nvim = {
        enable = true;
        settings = {
            formatters_by_ft = {
                cpp = [ "clang-format" ];
                python = [ "ruff_organize_imports" "ruff_format" ];
                nix = [ "alejandra" ];
                "_" = [ "trim_whitespace" "trim_empty_lines" "squeeze_blanks" ];
            };
        };
    };

    fugitive.enable = true;
    gitsigns.enable = true;

    oil = {
      enable = true;

      settings = {
        columns = [ "icon" ];
        view_options = {
          show_hidden = true;
        };
      };
    };

    treesitter = {
      enable = true;
      settings = {
        indent.enable = true;
        highlight.enable = true;
        ensure_installed = [ "cpp" "python" "yaml" "qmljs" ];
      };
    };
    treesitter-context.enable = true;


    copilot-lua = {
      enable = true;
      settings = {
        suggestion = {
          enabled = true;
          auto_trigger = true;
          keymap = {
            accept = "<M-l>";
            next = "<M-]>";
            prev = "<M-[>";
            dismiss = "<C-]>";
          };
        };
        panel.enabled = true;
      };
    };
    endwise.enable = true;

    dap.enable = true;
    dap-ui.enable = true;
    dap-virtual-text.enable = true;

    neotest = {
      enable = true;
      adapters = {
        cpputest.enable = true;
        gtest.enable = true;
      };
    };

    trouble.enable = true;
    todo-comments.enable = true;

    aerial = {
      enable = true;
      settings = {
        backends = [ "lsp" "treesitter" "mardown" "man" ];

        filter_kind = [
          "Class"
          "Constructor"
          "Method"
          "Function"
          "Field"
          "Property"
          "Variable"
          "Constant"
          "Enum"
          "EnumMember"
          "Interface"
          "Module"
          "Macro"
          "Struct"
        ];
 
        show_declaring_comp = true;
      };
    };
    visual-multi.enable = true;
    indent-blankline.enable = true;

    lualine = {
      enable = true;
      settings.options.theme = "auto";
    };

    bufferline.enable = true;
    illuminate.enable = true;

    telescope = {
      enable = true;
    };

    vim-css-color.enable = true;
    toggleterm = {
      enable = true;
      settings = {
        direction = "horizontal";
        open_mapping = "[[<C-\\>]]";
      };
    };
    diffview = {
        enable = true;
    };
    which-key.enable = true;
    mini = {
      enable = true;

      modules = {
        surround.mappings = { add = "gza"; delete = "gzd"; replace = "gzr"; find = "gzf"; find_left = "gzF"; highlight = "gzh"; update_n_lines = "gzn"; };
        pairs = {};
        comment = {};
        files = {};
      };
    };
    marks.enable = true;
    notify.enable = true;

    vim-dadbod.enable = true;
    vim-dadbod-ui.enable = true;
    vim-dadbod-completion.enable = true;
  };

  programs.nixvim.extraPlugins = [

  ];
}
