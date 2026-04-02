local M = {}

local options = {
    prompt = "Make recipes"
}

function M.setup()
    vim.keymap.set("n", "<leader>mr", function() M.run() end,
        { desc = "Select and run a Makefile recipe", noremap = true })
end

function M.find_makefile()
    local makefile_path = vim.fn.getcwd() .. "/Makefile"

    if vim.fn.filereadable(makefile_path) == 0 then
        return nil
    end

    return makefile_path
end

function M.parse_makefile(filepath)
    local recipes = {}

    if vim.fn.filereadable(filepath) == 0 then
        return {}
    end

    for line in io.lines(filepath) do
        local match = line:match("^([%a%d%-_]+)%s*:%s*")

        if match ~= nil and not line:find("^[%a%d-_]+%s*:=") then
            table.insert(recipes, match)
        end
    end

    return recipes
end

function M.get_recipe_content(filepath, recipe)
    if recipe == nil or recipe == "" then
        return {}
    end

    local recipe_content = {}
    local record = false

    for line in io.lines(filepath) do
        if line:find("^" .. vim.pesc(recipe)) and record == false then
            record = true
            table.insert(recipe_content, (line:gsub("^%s+", "")))
            goto continue
        end

        if line:find("^%s+") and record then
            table.insert(recipe_content, line)
        end

        if not line:find("^%s+") and record then
            record = false
        end

        ::continue::
    end

    return recipe_content
end

local function run_recipe(recipe)
    vim.cmd("tabnew|terminal make " .. recipe)
end

local function run_with_telescope(makefile_path, recipes)
    local ok_pickers, pickers = pcall(require, "telescope.pickers")
    local ok_finders, finders = pcall(require, "telescope.finders")
    local ok_config, config = pcall(require, "telescope.config")
    local ok_previewers, previewers = pcall(require, "telescope.previewers")
    local ok_actions, actions = pcall(require, "telescope.actions")
    local ok_act_state, actions_state = pcall(require, "telescope.actions.state")

    local use_telescope = ok_pickers and ok_finders and ok_config and ok_previewers and ok_actions and ok_act_state

    if not use_telescope then
        return nil
    end

    pickers.new({}, {
        prompt_title = options.prompt,
        finder = finders.new_table({ results = recipes }),
        sorter = config.values.generic_sorter({}),
        attach_mappings = function(prompt_bufnr)
            actions.select_default:replace(function()
                actions.close(prompt_bufnr)
                local recipe = actions_state.get_selected_entry()[1]

                run_recipe(recipe)
            end)

            return true
        end,
        previewer = previewers.new_buffer_previewer({
            define_preview = function(self, entry)
                local lines = M.get_recipe_content(makefile_path, entry[1])
                vim.api.nvim_buf_set_lines(self.state.bufnr, 0, -1, false, lines)
                vim.bo[self.state.bufnr].filetype = "make"
            end,
        })
    }):find()

    return true
end

local function run_with_select(recipes)
    vim.ui.select(
        recipes,
        options,
        function(recipe)
            if recipe == nil then return end
            run_recipe(recipe)
        end
    )
end

function M.run()
    local makefile_path = M.find_makefile()

    if makefile_path == nil then
        vim.notify("No Makefile found", vim.log.levels.WARN)
        return
    end

    local recipes = M.parse_makefile(makefile_path)

    if not run_with_telescope(makefile_path, recipes) then
        run_with_select(recipes)
    end
end

return M
