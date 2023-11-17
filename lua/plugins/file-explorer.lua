local options = {noremap = true, silent = true}
local keymap = vim.keymap.set

return {
    {
        "nvim-tree/nvim-tree.lua",
        lazy=false,
        dependencies = {
            "nvim-tree/nvim-web-devicons",
        },
        config = function ()
            keymap("n", "<leader>ls", vim.cmd.NvimTreeFocus)
            require("nvim-tree").setup({
                sort_by = "case_sensitive",
                auto_reload_on_write = true,
                disable_netrw = true,
                hijack_netrw = true,
                open_on_tab = false,
                hijack_cursor = true,
                update_cwd = true,
                hijack_directories = {
                    enable = true,
                    auto_open = true,
                },
                diagnostics = {
                    enable = true,
                    icons = {
                        hint = "",
                        info = "",
                        warning = "",
                        error = "",
                    },
                },
                update_focused_file = {
                    enable = true,
                    update_cwd = true,
                    ignore_list = {},
                },
                git = {
                    enable = true,
                    ignore = true,
                    timeout = 500,
                },
                view = {
                    cursorline = true,
                    width = 30,
                    side = "left",
                    number = false,
                    relativenumber = false,
                },
                renderer = {
                    special_files = {},
                    highlight_git = true,
                    highlight_opened_files = "all",
                    root_folder_modifier = ":t",
                    icons = {
                        show = {
                            file = true,
                            folder = true,
                            folder_arrow = true,
                            git = true,
                        },
                        glyphs = {
                            default = "",
                            symlink = "",
                            git = {
                                unstaged = "",
                                staged = "S",
                                unmerged = "",
                                renamed = "➜",
                                deleted = "",
                                untracked = "U",
                                ignored = "◌",
                            },
                            folder = {
                                default = "",
                                open = "",
                                empty = "",
                                empty_open = "",
                                symlink = "",
                            },
                        },
                    },
                },
                filters = {
                    git_ignored = false,
                    dotfiles = false,
                    custom = {
                        ".git",
                        "*.swp",
                        ".vscode",
                        ".ruff_cache",
                        ".pytest_cache",
                        "__pycache__",
                    },
                    exclude = {
                        ".gitignore"
                    },
                },
            })
        end
    },
    {
        "antosha417/nvim-lsp-file-operations",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-tree.lua"
        },
        config = true,
    },
    {
        'nvim-telescope/telescope.nvim',
        tag = "0.1.x",
        dependencies = {
            "nvim-lua/plenary.nvim",
            {"nivm-telescope/telescope-fzf-native.nvim", build="make"},
            "nvim-tree/nvim-web-devicons",
        },
        config = function ()
            local telescope_builtin = require("telescope.builtin")

            keymap("n", "<leader>t", ":Telescope<CR>", options)
            keymap('n', "<leader>lg", telescope_builtin.live_grep, options)
            keymap("n", "<leader>ff", telescope_builtin.find_files, options)
            keymap("n", "<leader>fgf", telescope_builtin.git_files, options)
            keymap("n", "<leader>fb", telescope_builtin.buffers, options)
            keymap("n", "<leader>tr", telescope_builtin.resume, options)
            -- keymap('n', '<leader>fh', telescope_builtin.help_tags, {})
        end
    },
}
