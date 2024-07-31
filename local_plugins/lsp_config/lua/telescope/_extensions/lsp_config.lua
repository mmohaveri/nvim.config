local Module = {}

function Module.lsp_config(opts)
    opts = opts or {}

    vim.notify("LSP CONFIG")
    local actions = require("telescope.actions")
    local finders = require("telescope.finders")
    local pickers = require("telescope.pickers")
    local sorters = require("telescope.sorters")
    local action_state = require("telescope.actions.state")

    local my_list = {
        "Item 1",
        "Item 2",
        "Item 3",
        "Item 4",
    }

    pickers
        .new(opts, {
            prompt_title = "LSP Config",
            finder = finders.new_table({
                results = my_list,
            }),
            sorter = sorters.get_generic_fuzzy_sorter(),
            attach_mappings = function(_, map)
                -- Define actions
                map("i", "<CR>", function(prompt_bufnr)
                    local selection = action_state.get_selected_entry()
                    actions.close(prompt_bufnr)
                    vim.notify("You selected: " .. selection[1])
                end)
                return true
            end,
        })
        :find()
end

return require("telescope").register_extension({
    exports = {
        lsp_config = Module.lsp_config,
    },
})
