local options = { noremap = true, silent = true }
local keymap = vim.keymap.set

local diagnostic_icons = {
    hint = "",
    info = "",
    warning = "",
    error = "",
}

local renderer_glyphs = {
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
}

return {
    {
        "nvim-tree/nvim-tree.lua",
        lazy = false,
        dependencies = {
            "nvim-tree/nvim-web-devicons",
        },
        config = function()
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
                    icons = diagnostic_icons,
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
                        glyphs = renderer_glyphs,
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
                        ".gitignore",
                    },
                },
            })
        end,
    },
    {
        "antosha417/nvim-lsp-file-operations",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-tree.lua",
        },
        config = true,
    },
    {
        "nvim-telescope/telescope.nvim",
        branch = "0.1.x",
        dependencies = {
            "nvim-lua/plenary.nvim",
            {
                "nvim-telescope/telescope-fzf-native.nvim",
                build = "make",
            },
            "nvim-tree/nvim-web-devicons",
        },
        config = function()
            local telescope = require("telescope")
            local telescope_actions = require("telescope.actions")
            local telescope_builtin = require("telescope.builtin")

            telescope.setup({
                defaults = {
                    mappings = {
                        i = {
                            ["<C-n>"] = false,
                            ["<C-j>"] = telescope_actions.move_selection_next,
                            ["<C-p>"] = false,
                            ["<C-k>"] = telescope_actions.move_selection_previous,

                            ["<C-c>"] = telescope_actions.close,

                            ["<Down>"] = telescope_actions.move_selection_next,
                            ["<Up>"] = telescope_actions.move_selection_previous,

                            ["<CR>"] = telescope_actions.select_default,
                            ["<C-x>"] = false,
                            ["<C-H>"] = telescope_actions.select_horizontal,
                            ["<C-v>"] = false,
                            ["<C-s>"] = telescope_actions.select_vertical,
                            ["<C-t>"] = false,

                            ["<C-u>"] = false,
                            ["<A-k>"] = telescope_actions.preview_scrolling_up,
                            ["<C-d>"] = false,
                            ["<A-j>"] = telescope_actions.preview_scrolling_down,
                            -- ["<C-f>"] = false,
                            -- ["<A-h>"] = telescope_actions.preview_scrolling_left,
                            -- ["<C-k>"] = false,  It's already overwritten with `move_selection_previous`
                            -- ["<A-l>"] = telescope_actions.preview_scrolling_right,

                            ["<PageUp>"] = telescope_actions.results_scrolling_up,
                            ["<PageDown>"] = telescope_actions.results_scrolling_down,
                            -- ["<M-f>"] = false,
                            -- ["<C-l>"] = telescope_actions.results_scrolling_left,
                            -- ["<M-k>"] = false,
                            -- ["<C-h>"] = telescope_actions.results_scrolling_right,

                            ["<Tab>"] = telescope_actions.toggle_selection + telescope_actions.move_selection_worse,
                            ["<S-Tab>"] = telescope_actions.toggle_selection + telescope_actions.move_selection_better,
                            ["<C-q>"] = telescope_actions.send_to_qflist + telescope_actions.open_qflist,
                            ["<M-q>"] = telescope_actions.send_selected_to_qflist + telescope_actions.open_qflist,

                            -- ["<C-l>"] = false -- disable actions.complete_tag,
                            ["<C-/>"] = telescope_actions.which_key,
                            ["<C-_>"] = false, -- disable actions.which_key
                            ["<C-w>"] = { "<c-s-w>", type = "command" },
                        },
                        n = {
                            ["j"] = telescope_actions.move_selection_next,
                            ["k"] = telescope_actions.move_selection_previous,

                            ["H"] = telescope_actions.move_to_top,
                            ["M"] = telescope_actions.move_to_middle,
                            ["L"] = telescope_actions.move_to_bottom,

                            ["<esc>"] = telescope_actions.close,

                            ["<CR>"] = telescope_actions.select_default,
                            ["<C-x>"] = false,
                            ["<C-H>"] = telescope_actions.select_horizontal,
                            ["<C-v>"] = false,
                            ["<C-s>"] = telescope_actions.select_vertical,
                            ["<C-t>"] = false,

                            ["<Tab>"] = telescope_actions.toggle_selection + telescope_actions.move_selection_worse,
                            ["<S-Tab>"] = telescope_actions.toggle_selection + telescope_actions.move_selection_better,
                            ["<C-q>"] = telescope_actions.send_to_qflist + telescope_actions.open_qflist,
                            ["<M-q>"] = telescope_actions.send_selected_to_qflist + telescope_actions.open_qflist,

                            ["<Down>"] = telescope_actions.move_selection_next,
                            ["<Up>"] = telescope_actions.move_selection_previous,
                            ["gg"] = telescope_actions.move_to_top,
                            ["G"] = telescope_actions.move_to_bottom,

                            ["<C-u>"] = false,
                            ["<A-k>"] = telescope_actions.preview_scrolling_up,
                            ["<C-d>"] = false,
                            ["<A-j>"] = telescope_actions.preview_scrolling_down,
                            -- ["<C-f>"] = false,
                            -- ["<A-h>"] = telescope_actions.preview_scrolling_left,
                            -- ["<C-k>"] = false,
                            -- ["<A-l>"] = telescope_actions.preview_scrolling_right,

                            ["<PageUp>"] = telescope_actions.results_scrolling_up,
                            ["<PageDown>"] = telescope_actions.results_scrolling_down,
                            -- ["<M-f>"] = false,
                            -- ["h"] = telescope_actions.results_scrolling_left,
                            -- ["<M-k>"] = false,
                            -- ["l"] = telescope_actions.results_scrolling_right,

                            ["?"] = false,
                            ["<C-/>"] = telescope_actions.which_key,
                        },
                    },
                },
            })
            keymap("n", "<leader>t", ":Telescope<CR>", options)
            keymap("n", "<leader>lg", telescope_builtin.live_grep, options)
            keymap("n", "<leader>ff", telescope_builtin.find_files, options)
            keymap("n", "<leader>fb", telescope_builtin.buffers, options)
            keymap("n", "<leader>tr", telescope_builtin.resume, options)
            keymap("n", "<leader>fh", telescope_builtin.help_tags, options)

            telescope.load_extension("fzf")
        end,
    },
}
