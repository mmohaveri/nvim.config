return {
    {
        "zaldih/themery.nvim",
        opts = {
            themes = {
                {
                    name = "vscode",
                    colorscheme = "vscode",
                    before = "require('vscode').load()",
                },
                {
                    name = "Dracula",
                    colorscheme = "dracula",
                    before = "require('dracula')",
                },
                {
                    name = "Dracula (Soft)",
                    colorscheme = "dracula-soft",
                    before = "require('dracula')",
                },
                {
                    name = "Github Dark",
                    colorscheme = "github_dark",
                    before = "require('github-theme')",
                },
                {
                    name = "Github Dark (Default)",
                    colorscheme = "github_dark_default",
                    before = "require('github-theme')",
                },
                {
                    name = "Github Dark (Dimmed)",
                    colorscheme = "github_dark_dimmed",
                    before = "require('github-theme')",
                },
                {
                    name = "Github Dark (Colorblind)",
                    colorscheme = "github_dark_colorblind",
                    before = "require('github-theme')",
                },
                {
                    name = "Github Dark (Tritanopia)",
                    colorscheme = "github_dark_tritanopia",
                    before = "require('github-theme')",
                },
                {
                    name = "rose pine",
                    colorscheme = "rose-pine-main",
                    before = "require('rose-pine')",
                },
                {
                    name = "rose pine moon",
                    colorscheme = "rose-pine-moon",
                    before = "require('rose-pine')",
                },
                {
                    name = "catppuccin (frappe)",
                    colorscheme = "catppuccin-frappe",
                    before = "require('catppuccin')",
                },
                {
                    name = "catppuccin (macchiato)",
                    colorscheme = "catppuccin-macchiato",
                    before = "require('catppuccin')",
                },
                {
                    name = "catppuccin (mocha)",
                    colorscheme = "catppuccin-mocha",
                    before = "require('catppuccin')",
                },
                {
                    name = "Night Fox",
                    colorscheme = "nightfox",
                    before = "require('nightfox')",
                },
                {
                    name = "Dusk Fox",
                    colorscheme = "duskfox",
                    before = "require('nightfox')",
                },
                {
                    name = "Nord Fox",
                    colorscheme = "nordfox",
                    before = "require('nightfox')",
                },
                {
                    name = "Tera Fox",
                    colorscheme = "terafox",
                    before = "require('nightfox')",
                },
                {
                    name = "Carbon Fox",
                    colorscheme = "carbonfox",
                    before = "require('nightfox')",
                },
                {
                    name = "One Dark",
                    colorscheme = "onedark",
                    before = "require('onedarkpro')",
                },
                {
                    name = "One Dark (Dark)",
                    colorscheme = "onedark_dark",
                    before = "require('onedarkpro')",
                },
                {
                    name = "One Nord",
                    colorscheme = "onenord",
                    before = "require('onenord')",
                },
                {
                    name = "Gruv Box Baby",
                    colorscheme = "gruvbox-baby",
                    before = "require('gruvbox-baby')",
                },
                {
                    name = "Kanagawa (Wave)",
                    colorscheme = "kanagawa-wave",
                    before = "require('kanagawa')",
                },
                {
                    name = "Kanagawa (Dragon)",
                    colorscheme = "kanagawa-dragon",
                    before = "require('kanagawa')",
                },
                {
                    name = "Tokyo Dark",
                    colorscheme = "tokyodark",
                    before = "require('tokyodark')",
                },
                {
                    name = "night owl",
                    colorscheme = "night-owl",
                    before = "require('night-owl')",
                },
                {
                    name = "One Monokai",
                    colorscheme = "one_monokai",
                    before = "require('one_monokai')",
                },
                {
                    name = "Ronny",
                    colorscheme = "ronny",
                    before = "require('one_monokai').setup()",
                },
                {
                    name = "Night City (Kabuki)",
                    colorscheme = "nightcity-kabuki",
                    before = "require('nightcity')",
                },
                {
                    name = "Night City (After Life)",
                    colorscheme = "nightcity-afterlife",
                    before = "require('nightcity')",
                },
            },
            themeConfigFile = "~/.config/nvim/plugin/theme.lua",
        },
    },
    {
        "Mofiqul/vscode.nvim",
        lazy = true,
        opts = {
            style = "dark",
            transparent = true, -- Enable transparent background
            italic_comments = true, -- Enable italic comment
            disable_nvimtree_bg = false, -- Disable nvim-tree background color
            color_overrides = {}, -- Override colors (see ./lua/vscode/colors.lua)
            group_overrides = { -- Override highlight groups (see ./lua/vscode/theme.lua)
                Cursor = {}, -- this supports the same val table as vim.api.nvim_set_hl
            },
        },
    },
    {
        "Mofiqul/dracula.nvim",
        lazy = true,
    },
    {
        "projekt0n/github-nvim-theme",
        lazy = true,
    },
    {
        "rose-pine/neovim",
        name = "rose-pine",
        lazy = true,
    },
    {
        "catppuccin/nvim",
        lazy = true,
    },
    {
        "EdenEast/nightfox.nvim",
        lazy = true,
    },
    {
        "olimorris/onedarkpro.nvim",
        lazy = true,
    },
    {
        "rmehri01/onenord.nvim",
        lazy = true,
    },
    {
        "luisiacc/gruvbox-baby",
        lazy = true,
    },
    {
        "rebelot/kanagawa.nvim",
        lazy = true,
    },
    {
        "tiagovla/tokyodark.nvim",
        lazy = true,
    },
    {
        "oxfist/night-owl.nvim",
        lazy = true,
    },
    {
        "cpea2506/one_monokai.nvim",
        lazy = true,
    },
    {
        "judaew/ronny.nvim",
        lazy = true,
    },
    {
        "cryptomilk/nightcity.nvim",
        lazy = true,
    },
}
