return {
    {
        "folke/snacks.nvim",
        priority = 1000,
        lazy = false,
        opts = {
            indent = {
                -- indent guides
                indent = {
                    enabled = true,
                    char = "┆",

                    priority = 1,
                    only_scope = false, -- only show indent guides of the scope
                    only_current = false, -- only show indent guides in the current window
                    hl = "SnacksIndent", -- hl groups for indent guides
                },
                -- the current scope guides
                scope = {
                    enabled = true,
                    char = "│",

                    priority = 200,
                    underline = false, -- underline the start of the scope
                    only_current = true, -- only show scope in the current window
                    hl = "SnacksIndent", -- hl groups for indent guides, default to SnacksIndentScope
                },
                -- render scopes as chunks
                chunk = {
                    enabled = false,
                },
                -- animate scopes
                animate = {
                    enabled = false,
                },
            },
        },
    },
    {
        "nvim-treesitter/nvim-treesitter-context",
        config = true,
        cmd = { "TSContext" },
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
        },
    },
    {
        "m4xshen/smartcolumn.nvim",
        event = {
            "BufReadPre",
            "BufNewFile",
        },
        opts = {
            colorcolumn = {
                "100",
                "120",
                "130",
            },
            disabled_filetypes = {
                "help",
                "text",
                "markdown",
                "NvimTree",
                "lazy",
                "mason",
            },
            scope = "window",
        },
    },
    {
        "lewis6991/gitsigns.nvim",
        event = {
            "BufReadPre",
            "BufNewFile",
        },
        opts = {
            signs = {
                add = { text = "│" },
                change = { text = "│" },
                delete = { text = "_" },
                topdelete = { text = "‾" },
                changedelete = { text = "~" },
                untracked = { text = "┆" },
            },
            signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
            numhl = true, -- Toggle with `:Gitsigns toggle_numhl`
            linehl = false, -- Toggle with `:Gitsigns toggle_linehl`
            word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`
            watch_gitdir = {
                follow_files = true,
            },
            attach_to_untracked = true,
            current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
            current_line_blame_opts = {
                virt_text = true,
                virt_text_pos = "right_align", -- 'eol' | 'overlay' | 'right_align'
                delay = 100,
                ignore_whitespace = false,
                virt_text_priority = 100,
            },
            current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d> - <summary>",
            sign_priority = 6,
            update_debounce = 100,
            status_formatter = nil, -- Use default
            max_file_length = 40000, -- Disable if file is longer than this (in lines)
            preview_config = {
                -- Options passed to nvim_open_win
                border = "single",
                style = "minimal",
                relative = "cursor",
                row = 0,
                col = 1,
            },
        },
    },
}
