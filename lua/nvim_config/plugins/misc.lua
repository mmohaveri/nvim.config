return {
    {
        "ThePrimeagen/vim-be-good",
        event = {},
       config = false,
    },
    {
        "sudormrfbin/cheatsheet.nvim",
        dependencies = {
            "nvim-telescope/telescope.nvim",
            "nvim-lua/popup.nvim",
            "nvim-lua/plenary.nvim",
        },
        config = function ()
            local actions = require('cheatsheet.telescope.actions')
            require("cheatsheet").setup({
                bundled_cheatsheets = false,
                bundled_plugin_cheatsheets = false,
                telescope_mappings = {
                    ['<CR>'] = actions.select_or_fill_commandline,
                    ['<C-CR>'] = actions.select_or_execute,
                    ['<C-Y>'] = actions.copy_cheat_value,
                    ['<C-E>'] = actions.edit_user_cheatsheet,
                }
            })

        end,
        init = function ()
            local keymap = vim.keymap.set

            local options = {noremap = true, silent = true}
            keymap("n", "<leader>`", ":Cheatsheet<CR>", options)
        end
    },
}

