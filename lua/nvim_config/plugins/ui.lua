return {
    {
        dir = "~/.config/nvim/local_plugins/winbar",
        event = {
            "BufReadPre",
            "BufNewFile",
        },
        dependencies = {
            "nvim-web-devicons",
        },
        config = true,
    },
    {
        "nvim-lualine/lualine.nvim",
        event = {
            "BufReadPre",
            "BufNewFile",
        },
        config = true,
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
        "stevearc/dressing.nvim",
        event = "VeryLazy",
        config = true,
    },
    {
        "rcarriga/nvim-notify",
        event = "VeryLazy",
        opts = {
            render = "wrapped-compact",
            stages = "slide",
            timeout = 1000,
        },
    },
}
