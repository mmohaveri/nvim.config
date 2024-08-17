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
                        ".github",
                    },
                },
            })
        end,
    },
}
