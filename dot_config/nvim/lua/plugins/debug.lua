return {
  -- Core DAP
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "rcarriga/nvim-dap-ui",               -- UI pour le debug
      "nvim-neotest/nvim-nio",
      "theHamsta/nvim-dap-virtual-text",    -- variables inline
      "jay-babu/mason-nvim-dap.nvim",       -- gestion adaptateurs via Mason
      "williamboman/mason.nvim",
    },
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")

      -- UI setup
      dapui.setup()

      -- Ouvrir / fermer automatiquement l'UI
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
      end

      -- Virtual text inline
      require("nvim-dap-virtual-text").setup()

      -- Keymaps principaux
      vim.keymap.set("n", "<F5>", dap.continue, { desc = "Start/Continue" })
      vim.keymap.set("n", "<F10>", dap.step_over, { desc = "Step Over" })
      vim.keymap.set("n", "<F11>", dap.step_into, { desc = "Step Into" })
      vim.keymap.set("n", "<F12>", dap.step_out, { desc = "Step Out" })

      vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, { desc = "Toggle Breakpoint" })
      vim.keymap.set("n", "<leader>dB", function()
        dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
      end, { desc = "Conditional Breakpoint" })

      vim.keymap.set("n", "<leader>dr", dap.repl.open, { desc = "Open REPL" })
      vim.keymap.set("n", "<leader>dl", dap.run_last, { desc = "Run last debug session" })

      -- Mason DAP setup
      require("mason-nvim-dap").setup({
        automatic_setup = true,
        handlers = {}, -- peut contenir des configs custom si besoin
        ensure_installed = {
          "java-debug-adapter", -- Java
          "java-test",          -- Java tests
          "codelldb",           -- Rust, C, C++
          "js-debug-adapter",   -- Node, TS, JS
          "delve",              -- Go
        },
      })
    end,
  },
}
