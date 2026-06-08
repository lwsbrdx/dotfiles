return {
  {
    "carlos-algms/agentic.nvim",

    opts = function()
      -- Détecte le provider disponible selon la machine
      local provider
      if vim.fn.executable("claude-agent-acp") == 1 then
        provider = "claude-agent-acp"
      elseif vim.fn.executable("opencode") == 1 then
        provider = "opencode-acp"
      else
        provider = "claude-agent-acp"
      end

      return {
        provider = provider,
        windows = {
          position = "right",
          width = "40%",
        },
        diff_preview = {
          layout = "split",
        },
      }
    end,

    keys = {
      {
        "<leader>aa",
        function() require("agentic").toggle() end,
        mode = { "n", "v" },
        desc = "Toggle chat",
      },
      {
        "<leader>af",
        function() require("agentic").add_selection_or_file_to_context() end,
        mode = { "n", "v" },
        desc = "Fichier/sélection → contexte",
      },
      {
        "<leader>ac",
        function() require("agentic").new_session() end,
        mode = { "n" },
        desc = "Nouvelle session",
      },
      {
        "<leader>ar",
        function() require("agentic").restore_session() end,
        mode = { "n" },
        desc = "Restaurer session",
      },
      {
        "<leader>as",
        function() require("agentic").switch_provider() end,
        mode = { "n" },
        desc = "Changer de provider",
      },
      {
        "<leader>ad",
        function() require("agentic").add_current_line_diagnostics() end,
        mode = { "n" },
        desc = "Diagnostic ligne courante",
      },
      {
        "<leader>aD",
        function() require("agentic").add_buffer_diagnostics() end,
        mode = { "n" },
        desc = "Diagnostics du buffer",
      },
    },
  },
}
