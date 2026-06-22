{ config, lib, ... }:

{
  programs.nixvim.keymaps = [
    # --- GENERAL  ---
    {
      mode = "n";
      key = "<leader>e";
      action = "<cmd>Oil<cr>";
      options = { desc = "Explorateur de fichiers (Oil)"; };
    }
    {
      mode = "n";
      key = "<leader>f";
      action = config.lib.nixvim.utils.mkRaw ''
        function()
          require("conform").format({ async = true, lsp_fallback = true })
        end
      '';
      options = { desc = "Format with conform"; };
    }
    {
      mode = "n";
      key = "<leader>ff";
      action = "<cmd>Telescope find_files<cr>";
      options = { desc = "Trouver un fichier"; };
    }
    {
      mode = "n";
      key = "<leader>fg";
      action = "<cmd>Telescope live_grep<cr>";
      options = { desc = "Recherche textuelle globale (Grep)"; };
    }
    {
      mode = "n";
      key = "<leader>fb";
      action = "<cmd>Telescope buffers<cr>";
      options = { desc = "Liste des buffers ouverts"; };
    }

    # --- LSP ---
    {
      mode = "n";
      key = "gd";
      action = config.lib.nixvim.utils.mkRaw "vim.lsp.buf.definition";
      options = { desc = "Aller à la définition"; };
    }
    {
      mode = "n";
      key = "gr";
      action = "<cmd>Telescope lsp_references<cr>";
      options = { desc = "Afficher les références"; };
    }
    {
      mode = "n";
      key = "K";
      action = config.lib.nixvim.utils.mkRaw "vim.lsp.buf.hover";
      options = { desc = "Documentation au survol"; };
    }
    {
      mode = "n";
      key = "<leader>ca";
      action = config.lib.nixvim.utils.mkRaw "vim.lsp.buf.code_action";
      options = { desc = "Actions correctives (Quick Fix)"; };
    }
    {
      mode = "n";
      key = "<leader>rn";
      action = config.lib.nixvim.utils.mkRaw "vim.lsp.buf.rename";
      options = { desc = "Renommer le symbole (Refactor)"; };
    }

    # --- DAP ---
    {
      mode = "n";
      key = "<F5>";
      action = config.lib.nixvim.utils.mkRaw "require('dap').continue";
      options = { desc = "Debug: Démarrer/Continuer"; };
    }
    {
      mode = "n";
      key = "<F10>";
      action = config.lib.nixvim.utils.mkRaw "require('dap').step_over";
      options = { desc = "Debug: Pas à pas (Over)"; };
    }
    {
      mode = "n";
      key = "<F11>";
      action = config.lib.nixvim.utils.mkRaw "require('dap').step_into";
      options = { desc = "Debug: Entrer dans (Into)"; };
    }
    {
      mode = "n";
      key = "<F12>";
      action = config.lib.nixvim.utils.mkRaw "require('dap').step_out";
      options = { desc = "Debug: Sortir de (Out)"; };
    }
    {
      mode = "n";
      key = "<leader>b";
      action = config.lib.nixvim.utils.mkRaw "require('dap').toggle_breakpoint";
      options = { desc = "Debug: Toggle Breakpoint"; };
    }
    {
      mode = "n";
      key = "<leader>du";
      action = config.lib.nixvim.utils.mkRaw "require('dapui').toggle";
      options = { desc = "Debug: Afficher/Cacher l'UI"; };
    }

    # --- Neotest ---
    {
      mode = "n";
      key = "<leader>tr";
      action = config.lib.nixvim.utils.mkRaw "require('neotest').run.run";
      options = { desc = "Lancer le test le plus proche"; };
    }
    {
      mode = "n";
      key = "<leader>tf";
      action = config.lib.nixvim.utils.mkRaw "function() require('neotest').run.run(vim.fn.expand('%')) end";
      options = { desc = "Lancer tous les tests du fichier"; };
    }

    # --- Trouble ---
    {
      mode = "n";
      key = "<leader>xx";
      action = "<cmd>Trouble diagnostics toggle<cr>";
      options = { desc = "Liste des erreurs du projet"; };
    }

    # --- TERMINAL ---
    {
      mode = "n";
      key = "<leader>th";
      action = "<cmd>ToggleTerm direction=horizontal<cr>";
      options = { desc = "Terminal Horizontal"; };
    }
    {
      mode = "n";
      key = "<leader>tf";
      action = "<cmd>ToggleTerm direction=float<cr>";
      options = { desc = "Terminal Flottant"; };
    }
  ];

  # --- COPILOT (Sans LSP, suggestions Ghost Text) ---
  programs.nixvim.plugins.copilot-lua.settings.suggestion.keymap = {
    accept = "<M-l>"; # Alt + l pour accepter
    next = "<M-]>";   # Alt + ] pour suggestion suivante
    prev = "<M-[>";   # Alt + [ pour suggestion précédente
    dismiss = "<C-]>"; # Ctrl + ] pour annuler
  };
}
