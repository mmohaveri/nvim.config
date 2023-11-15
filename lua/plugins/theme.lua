return {
    "Mofiqul/vscode.nvim",
    priority = 1000,
    init = function () require('vscode').load() end,
    opts = {
        style = 'dark',
        transparent = true,          -- Enable transparent background
        italic_comments = true,      -- Enable italic comment
        disable_nvimtree_bg = false, -- Disable nvim-tree background color
        color_overrides = {},        -- Override colors (see ./lua/vscode/colors.lua)
        group_overrides = {          -- Override highlight groups (see ./lua/vscode/theme.lua)
            Cursor = {},             -- this supports the same val table as vim.api.nvim_set_hl
        },
    },
}

