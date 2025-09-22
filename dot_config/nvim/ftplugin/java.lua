local jdtls = require("jdtls")
local dap = require("dap")
local uv = vim.loop

-- Nom du projet et workspace
local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:t")
local workspace_dir = vim.fn.stdpath("data") .. "/site/java/workspace-root/" .. project_name

-- Bundles java-test et java-debug-adapter
local bundles = {}
local mason_path = vim.fn.stdpath("data") .. "/mason/packages/"
for _, jar in ipairs(vim.fn.glob(mason_path .. "java-test/**/*.jar", true, true)) do
    table.insert(bundles, jar)
end
for _, jar in ipairs(vim.fn.glob(mason_path .. "java-debug-adapter/**/*.jar", true, true)) do
    table.insert(bundles, jar)
end

-- Config JDTLS
local config = {
    cmd = { "jdtls", "-data", workspace_dir },
    root_dir = require("jdtls.setup").find_root({ ".git", "mvnw", "gradlew", "pom.xml" }),
    init_options = { bundles = bundles },
}

jdtls.start_or_attach(config)

-- Keymaps Java
vim.keymap.set("n", "<leader>tm", jdtls.test_nearest_method, { desc = "Test nearest method" })
vim.keymap.set("n", "<leader>tc", jdtls.test_class, { desc = "Test class" })
vim.keymap.set("n", "<leader>tr", jdtls.test_nearest_method, { desc = "Re-run last test" })

-- Fonction compilation automatique
local function compile_project()
    local root = config.root_dir
    local cmd = nil

    if uv.fs_stat(root .. "/pom.xml") then
        cmd = { "mvn", "compile" }
    elseif uv.fs_stat(root .. "/build.gradle") or uv.fs_stat(root .. "/gradlew") then
        cmd = { "gradle", "build" }
    end

    if cmd then
        print("Compiling project…")
        local handle = uv.spawn(cmd[1], { args = { unpack(cmd, 2) }, cwd = root }, function(code)
            if code == 0 then
                print("Compilation OK")
            else
                print("Compilation failed with code", code)
            end
        end)
        -- sortie standard
        uv.read_start(handle.stdout, function(err, data)
            if data then print(data) end
        end)
    end
end

-- Setup Mason DAP pour Java
-- require("mason-nvim-dap").setup({ automatic_setup = true })
-- dap.adapters.java = require("mason-nvim-dap").get_adapter("java-debug-adapter")-- DAP Java

vim.defer_fn(function()
    local mason_dap_ok, mason_dap = pcall(require, "mason-nvim-dap")
    if not mason_dap_ok then
        vim.notify("mason-nvim-dap not found", vim.log.levels.ERROR)
        return
    end

    mason_dap.setup({ automatic_setup = true })

    local java_adapter_ok, java_adapter = pcall(mason_dap.get_adapter, "java-debug-adapter")
    if java_adapter_ok then
        dap.adapters.java = java_adapter
    else
        vim.notify("java-debug-adapter not found in mason-nvim-dap", vim.log.levels.ERROR)
    end
end, 0)

dap.configurations.java = {
    {
        type = "java",
        request = "launch",
        name = "Debug Current File",
        mainClass = function()
            return vim.fn.input("Main class > ", "", "file")
        end,
        projectName = vim.fn.fnamemodify(vim.fn.getcwd(), ":t"),
    },
}

-- Keymaps DAP
vim.keymap.set("n", "<F5>", function()
    compile_project()
    dap.continue()
end, { desc = "Compile + Start/Continue Debug" })
vim.keymap.set("n", "<F10>", dap.step_over, { desc = "Step Over" })
vim.keymap.set("n", "<F11>", dap.step_into, { desc = "Step Into" })
vim.keymap.set("n", "<F12>", dap.step_out, { desc = "Step Out" })
vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, { desc = "Toggle Breakpoint" })
vim.keymap.set("n", "<leader>dB", function()
    dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
end, { desc = "Conditional Breakpoint" })
vim.keymap.set("n", "<leader>dr", dap.repl.open, { desc = "Open Debug REPL" })
vim.keymap.set("n", "<leader>dl", dap.run_last, { desc = "Run last debug session" })
