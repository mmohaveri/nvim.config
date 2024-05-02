local keymap = vim.keymap.set

return {
    {
        "akinsho/toggleterm.nvim",
        version = "*",
        opts = {
            size = 20,
            open_mapping = [[<C-\>]],
            hide_numbers = true,
            shade_filetypes = {},
            autochdir = false,
            shade_terminals = true,
            shading_factor = 2,
            start_in_insert = true,
            insert_mappings = true, -- Apply the "open mapping" even in insert mode.
            persist_size = true,
            direction = "horizontal",
            close_on_exit = true,
            shell = vim.o.shell,
            auto_scroll = true,
            winbar = {
                enabled = false,
            },
        },
        init = function()
            function _G.set_terminal_keymaps()
                local opts = { noremap = true, silent = true, buffer = 0 }
                keymap("t", "<esc>", [[<C-\><C-n>]], opts)
            end

            vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")
        end,
    },
    {
        "willothy/flatten.nvim",
        dependencies = {
            "akinsho/toggleterm.nvim",
        },
        lazy = false,
        priority = 1001,
        opts = function()
            local saved_terminal

            return {
                window = {
                    open = "current",
                },
                callbacks = {
                    should_block = function(argv)
                        -- argv contains all the parts of the CLI command, including Neovim's path, commands, options and files.
                        -- We would block if we find the `-b` flag. This allows you to use `nvim -b file1`.
                        -- we also block if we find the diff-mode option
                        return vim.tbl_contains(argv, "-b") or vim.tbl_contains(argv, "-d")
                    end,
                    pre_open = function()
                        local toggleterm = require("toggleterm.terminal")
                        local terminal_id = toggleterm.get_focused_id()
                        saved_terminal = toggleterm.get(terminal_id)
                    end,
                    post_open = function(bufnr, winnr, file_type, is_blocking)
                        vim.api.nvim_set_current_win(winnr)

                        -- If the file is a git commit, create one-shot autocmd to delete its buffer on closing it (leaving the window)
                        if file_type == "gitcommit" or file_type == "gitrebase" then
                            vim.api.nvim_create_autocmd("BufLeave", {
                                buffer = bufnr,
                                once = true,
                                callback = vim.schedule_wrap(function() vim.api.nvim_buf_delete(bufnr, {}) end),
                            })
                        end
                    end,
                    block_end = function()
                        -- After blocking ends (for a git commit, etc), reopen the terminal
                        vim.schedule(function()
                            if saved_terminal then
                                saved_terminal:open()
                                saved_terminal = nil
                            end
                        end)
                    end,
                },
            }
        end,
    },
    {
        "ryanmsnyder/toggleterm-manager.nvim",
        dependencies = {
            "akinsho/toggleterm.nvim",
            "nvim-telescope/telescope.nvim",
            "nvim-lua/plenary.nvim",
        },
        config = true,
    },
}
