{config, pkgs, inputs, ...}:

{
  programs.nixvim.plugins = {
    lsp = {
      enable = true;
      inlayHints = true;
      servers = {
        clangd.enable = true;
        neocmake.enable = true;
        pyright.enable = true;
        ruff.enable = true;
        nixd.enable = true;
        qmlls.enable = true;
        qmlls.cmd = [ "qmlls" "-E" ];
      };
    };

    rustaceanvim = {
      enable = true;
      settings = {
        server = {
          default_settings = {
            rust-analyzer = {
              check = {
                command = "clippy";
              };
              cargo = {
                allFeatures = true;
              };
              procMacro = {
                enable = true;
              };
            };
          };
        };
      };
    };

    web-devicons.enable = true;

    blink-cmp = {
      enable = true;
      settings = {
        keymap = {
          "<C-n>" = [ "select_next" "fallback" ];
          "<C-p>" = [ "select_prev" "fallback" ];
          "<C-space>" = [ "show" "show_documentation" "hide_documentation" ];
          "<C-e>" = [ "hide" ];
          "<C-CR>" = [ "select_and_accept" ];
        };

        sources = {
          default = [ "lsp" "path" "buffer" "snippets" ];
          providers = {
            dadbod = {
              name = "Dadbod";
              module = "vim_dadbod_completion.blink";
            };
          };
        };

        completion = {
          list = {
            selection.preselect = false;
            selection.auto_insert = false;
          };

          menu = {
            border = [ "╭" "─" "╮" "│" "╯" "─" "╰" "│" ];
            scrollbar = false;
          };

          documentation = {
            window.border = [ "╭" "─" "╮" "│" "╯" "─" "╰" "│" ];
            window.scrollbar = false;
            auto_show = true;
            auto_show_delay_ms = 200;
          };

          trigger = {
            show_on_keyword = true;
            show_on_trigger_character = true;
          };
        };
      };
    };

    render-markdown.enable = true;

    conform-nvim = {
      enable = true;
      settings = {
        formatters_by_ft = {
          cpp = [ "clang-format" ];
          python = [ "ruff_organize_imports" "ruff_format" ];
          nix = [ "alejandra" ];
          rust = [ "rustfmt" ];
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
        ensure_installed = [ "cpp" "python" "yaml" "qml" "qmljs" "rust" "toml" ];
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
            accept = "<C-l>";
          };
        };
        panel.enabled = true;
      };
    };
    endwise.enable = true;

    presence.enable = true;
    dap.enable = true;
    dap-ui.enable = true;
    dap-virtual-text.enable = true;

    neotest = {
      enable = true;
      adapters = {
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

    vectorcode = {
      enable = true;
      integrations.codecompanion.enable = true;
      settings = {
        async_backend = "lsp";
      };
    };
    codecompanion = {
      enable = true;
      settings = {
        adapters = {
          http = {
            ollama_qwen.__raw = ''
              function()
                return require("codecompanion.adapters").extend("ollama", {
                  schema = {
                    model = {
                      default = "qwen2.5-coder:14b",
                    },
                  },
                })
              end
              '';
          };
        };
        strategies = {
          agent = {
            adapter = "claude_code";
          };
          chat = {
            adapter = "claude_code";
          };
          inline = {
            adapter = "ollama_qwen";
          };
        };
      };
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
