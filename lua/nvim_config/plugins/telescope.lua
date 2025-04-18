return {
    {
        "nvim-telescope/telescope.nvim",
        branch = "0.1.x",
        lazy = true,
        dependencies = {
            "nvim-lua/plenary.nvim",
            {
                "nvim-telescope/telescope-fzf-native.nvim",
                build = "make",
            },
            "nvim-tree/nvim-web-devicons",
            "OliverChao/telescope-picker-list.nvim",
            "nvim-telescope/telescope-symbols.nvim",
            {
                "nvim-telescope/telescope-live-grep-args.nvim",
                version = "^1.0.0",
            },
        },
        config = function()
            local telescope = require("telescope")
            local telescope_actions = require("telescope.actions")
            local telescope_builtin = require("telescope.builtin")
            local telescope_themes = require("telescope.themes")

            local config_options = {
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
                            ["<C-a>"] = telescope_actions.send_to_qflist + telescope_actions.open_qflist,
                            ["<C-q>"] = telescope_actions.send_selected_to_qflist + telescope_actions.open_qflist,

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
                            ["<C-a>"] = telescope_actions.send_to_qflist + telescope_actions.open_qflist,
                            ["<C-q>"] = telescope_actions.send_selected_to_qflist + telescope_actions.open_qflist,

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
                    file_ignore_patterns = {
                        "^node_modules/",
                        "^dist/",
                    },
                    vimgrep_arguments = {
                        "rg",
                        "--color=never",
                        "--no-heading",
                        "--with-filename",
                        "--line-number",
                        "--column",
                        "--smart-case",
                        "-u",
                    },
                },
                extensions = {
                    picker_list = {
                        opts = {
                            symbols = telescope_themes.get_dropdown({}),
                        },
                        excluded_pickers = {
                            "fzf",
                            "resume",
                            -- "fd",
                            "find_files",
                            -- "git_bcommit",
                            "git_branches",
                            "git_commits",
                            "git_stash",
                            "git_status",
                            "git_files",
                        },
                        user_pickers = {
                            {
                                "gitmoji",
                                function()
                                    telescope_builtin.symbols(telescope_themes.get_dropdown({
                                        prompt_title = "gitmoji",
                                        sources = { "gitmoji" },
                                    }))
                                end,
                            },
                            {
                                "terminals",
                                function() require("toggleterm-manager").open(telescope_themes.get_dropdown({})) end,
                            },
                            {
                                "EZ-LSP",
                                function()
                                    local _, extension_is_loaded = pcall(
                                        function() telescope.extensions.ez_lsp.ez_lsp() end
                                    )

                                    if not extension_is_loaded then
                                        telescope.load_extension("ez_lsp")
                                        telescope.extensions.ez_lsp.ez_lsp()
                                    end
                                end,
                            },
                            {
                                "emoji",
                                function()
                                    local _, extension_is_loaded = pcall(
                                        function() telescope.extensions.emoji.emoji() end
                                    )

                                    if not extension_is_loaded then
                                        telescope.load_extension("emoji")
                                        telescope.extensions.emoji.emoji()
                                    end
                                end,
                            },
                            {
                                "glyph",
                                function()
                                    local _, extension_is_loaded = pcall(
                                        function() telescope.extensions.glyph.glyph() end
                                    )

                                    if not extension_is_loaded then
                                        telescope.load_extension("glyph")
                                        telescope.extensions.glyph.glyph()
                                    end
                                end,
                            },
                            {
                                "luasnip",
                                function()
                                    local _, extension_is_loaded = pcall(
                                        function() telescope.extensions.luasnip.luasnip() end
                                    )

                                    if not extension_is_loaded then
                                        telescope.load_extension("luasnip")
                                        telescope.extensions.luasnip.luasnip()
                                    end
                                end,
                            },
                            {
                                "find files",
                                telescope_builtin.find_files,
                            },
                            {
                                "find git files",
                                telescope_builtin.git_files,
                            },
                            {
                                "git branch (gb)",
                                telescope_builtin.git_branches,
                            },
                            {
                                "git log",
                                telescope_builtin.git_commits,
                            },
                            {
                                "git stash",
                                telescope_builtin.git_stash,
                            },
                            {
                                "git status (gst)",
                                telescope_builtin.git_status,
                            },
                            {
                                "lazy",
                                function() vim.cmd(":Lazy") end,
                            },
                            {
                                "message",
                                function() vim.cmd(":messages") end,
                            },
                            {
                                "vim-be-good",
                                function()
                                    require("lazy").load({ plugins = { "vim-be-good" } })
                                    vim.cmd("VimBeGood")
                                end,
                            },
                        },
                    },
                },
            }

            telescope.setup(config_options)

            telescope.load_extension("fzf")
            telescope.load_extension("notify")
            telescope.load_extension("live_grep_args")

            -- extenstions loaded before picker_list will automatically get registered in its list.
            telescope.load_extension("picker_list")
            -- extenstions loaded after picker_list should be registered manaually
        end,
    },
    {
        {
            "xiyaowong/telescope-emoji.nvim",
            lazy = true,
        },
        {
            "ghassan0/telescope-glyph.nvim",
            lazy = true,
        },
    },
}
