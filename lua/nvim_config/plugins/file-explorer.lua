local diagnostic_icons = {
    hint = " ",
    info = " ",
    warning = " ",
    error = " ",
}

local renderer_glyphs = {
    default = " ",
    symlink = " ",
    git = {
        unstaged = "",
        staged = "S",
        unmerged = " ",
        renamed = "➜",
        deleted = " ",
        untracked = "U",
        ignored = "◌ ",
    },
    folder = {
        default = " ",
        open = " ",
        empty = " ",
        empty_open = " ",
        symlink = " ",
    },
}

return {
    {
        "nvim-tree/nvim-tree.lua",
        lazy = false,
        dependencies = {
            "nvim-tree/nvim-web-devicons",
        },
        opts = {
            hijack_cursor = true,
            auto_reload_on_write = true,
            disable_netrw = true,
            hijack_netrw = true,
            hijack_unnamed_buffer_when_opening = false,
            root_dirs = {},
            prefer_startup_root = true,
            sync_root_with_cwd = true,
            reload_on_bufenter = false,
            respect_buf_cwd = false,
            select_prompts = true, -- Necessary when using a UI prompt decorator such as dressing.nvim
            sort = {
                sorter = "case_sensitive",
                folders_first = true,
            },
            view = {
                centralize_selection = true,
                cursorline = true,
                debounce_delay = 15, -- 15ms
                side = "left",
                preserve_window_proportions = true,
                number = false,
                relativenumber = false,
                signcolumn = "yes",
                float = {
                    enable = true,
                    quit_on_focus_loss = true,
                    open_win_config = function()
                        local screen_w = vim.opt.columns:get()
                        local screen_h = vim.opt.lines:get() - vim.opt.cmdheight:get()
                        local window_w = screen_w * 0.5
                        local window_h = screen_h * 0.7
                        local window_w_int = math.floor(window_w)
                        local window_h_int = math.floor(window_h)
                        local center_x = (screen_w - window_w) / 2
                        local center_y = ((vim.opt.lines:get() - window_h) / 2) - vim.opt.cmdheight:get()
                        return {
                            relative = "editor",
                            width = window_w_int,
                            height = window_h_int,
                            row = center_y,
                            col = center_x,
                            border = "rounded",
                            title = "File Tree",
                            title_pos = "center",
                        }
                    end,
                },
            },
            renderer = {
                add_trailing = true,
                group_empty = true,
                indent_width = 2,
                special_files = {},
                hidden_display = "all",
                symlink_destination = true,
                highlight_git = "all",
                highlight_diagnostics = "all",
                highlight_opened_files = "icon",
                highlight_modified = "all",
                indent_markers = {
                    enable = false,
                },
                icons = {
                    show = {
                        file = true,
                        folder = true,
                        folder_arrow = false,
                        git = true,
                        modified = true,
                        hidden = false,
                        diagnostics = true,
                        bookmarks = true,
                    },
                    glyphs = renderer_glyphs,
                },
                root_folder_modifier = ":t",
            },

            open_on_tab = false,
            update_cwd = false,
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
                    ".github",
                },
            },
        },
    },
}
