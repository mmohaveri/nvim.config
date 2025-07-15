return {
    {
        dir = "~/.config/nvim/local_plugins/winbar",
        dependencies = {
            "nvim-tree/nvim-web-devicons",
        },
        event = {
            "BufReadPre",
            "BufNewFile",
        },

        config = true,
    },
    {
        "nvim-lualine/lualine.nvim",
        dependencies = {
            "nvim-tree/nvim-web-devicons",
        },
        event = {
            "BufReadPre",
            "BufNewFile",
        },
        opts = {
            options = {
                globalstatus = true,
            },
            sections = {
                lualine_a = { "mode" },
                lualine_b = {
                    {
                        "branch",
                        on_click = function() require("snacks").picker.git_branches({ layout = "dropdown" }) end,
                    },
                    {
                        "diff",
                        on_click = function() require("snacks").picker.git_diff() end,
                    },
                    {
                        "diagnostics",
                        on_click = function() require("snacks").picker.diagnostics_buffer() end,
                    },
                },
                lualine_c = {
                    {
                        "filename",
                        newfile_status = true,
                    },
                },
                lualine_x = { "searchcount", "encoding", "filetype", "lsp_status" },
                lualine_y = {},
                lualine_z = { "location", "progress" },
            },
            extensions = {
                "lazy",
                "man",
                "nvim-tree",
                "quickfix",
            },
        },
    },
    {
        "folke/snacks.nvim",
        priority = 1000,
        lazy = false,
        opts = {
            -- replace `vim.ui.input` with the snacks input
            input = {
                enabled = true,
            },
            picker = {
                matcher = {
                    sort_empty = true,
                },
                -- replace `vim.ui.select` with the snacks picker
                ui_select = true,
                sources = {
                    autocmds = {
                        layout = "vscode",
                    },
                    commands = {
                        layout = "dropdown",
                    },
                    explorer = {
                        -- Configure explorer picker to use responsive floating layout
                        layout = {
                            preset = function() return vim.o.columns >= 120 and "default" or "dropdown" end,
                            preview = function() return vim.o.columns >= 120 end,
                        },
                        -- Configure explorer picker to close after opening a file
                        jump = { close = true },
                    },
                    keymaps = {
                        layout = "dropdown",
                        -- Configure keymaps picker to use a different preview mechanism
                        preview = require("nvim_config.utils.snacks.pickers").keymaps_preview,
                    },
                    qflist = {
                        show_empty = true,
                    },
                    buffers = {
                        show_empty = true,
                    },
                },
            },
            notifier = {
                timeout = 2000,
                style = "fancy",
            },
        },
    },
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        opts = {
            preset = "helix",
            plugins = {
                marks = true,
                registers = true,
                spelling = {
                    enabled = true,
                    suggestions = 20,
                },
                presets = {
                    operators = true,
                    motions = true,
                    text_objects = true,
                    windows = true,
                    nav = true,
                    z = true,
                    g = true,
                },
            },
            win = {
                title_pos = "center",
            },
            expand = 5,
        },
    },
}
