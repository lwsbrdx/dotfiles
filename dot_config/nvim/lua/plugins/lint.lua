return {
  {
    "mfussenegger/nvim-lint",
    ft = { "php" },
    config = function()
      local lint = require("lint")

      -- Résolution du binaire phpstan : PATH → vendor/bin → vim.g.phpstan_path
      local function resolve_phpstan()
        if vim.fn.executable("phpstan") == 1 then
          return "phpstan"
        end
        local vendor = vim.fn.fnamemodify("vendor/bin/phpstan", ":p")
        if vim.uv.fs_stat(vendor) then
          return vendor
        end
        local custom = vim.g.phpstan_path
        if custom and vim.fn.executable(custom) == 1 then
          return custom
        end
        return nil
      end

      lint.linters.phpstan = vim.tbl_deep_extend("force", lint.linters.phpstan, {
        cmd = function()
          return resolve_phpstan() or "phpstan"
        end,
      })

      lint.linters_by_ft = {
        php = { "phpstan" },
      }

      vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost" }, {
        pattern = "*.php",
        callback = function()
          if resolve_phpstan() then
            lint.try_lint()
          end
        end,
      })
    end,
  },
}
