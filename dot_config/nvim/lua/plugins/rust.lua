return {
  {
    "mrcjkb/rustaceanvim",
    version = "^5",
    ft = { "rust" },
    init = function()
      vim.g.rustaceanvim = function()
        local mason_data = vim.fn.stdpath("data")
        local codelldb_path = mason_data .. "/mason/bin/codelldb"
        local liblldb_path = mason_data
          .. "/mason/packages/codelldb/extension/lldb/lib/liblldb.dylib"
        return {
          dap = {
            adapter = {
              type = "server",
              port = "${port}",
              executable = {
                command = codelldb_path,
                args = { "--liblldb", liblldb_path, "--port", "${port}" },
              },
            },
          },
          server = {
            capabilities = require("cmp_nvim_lsp").default_capabilities(),
            on_attach = function(_, bufnr)
              local map = function(key, cmd, desc)
                vim.keymap.set("n", key, cmd, { buffer = bufnr, desc = desc })
              end
              map("<leader>rr", function() vim.cmd.RustLsp("runnables") end, "Rust runnables")
              map("<leader>rd", function() vim.cmd.RustLsp("debuggables") end, "Rust debuggables")
              map("<leader>re", function() vim.cmd.RustLsp("explainError") end, "Rust explain error")
            end,
            settings = {
              ["rust-analyzer"] = {
                checkOnSave = true,
                check = { command = "clippy" },
                diagnostics = { enable = true },
              },
            },
          },
        }
      end
    end,
  },
}
