local Module = {}


local smartcolumn_config = {
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
}

Module.plugin_spec = {
    {
        "nvim-lualine/lualine.nvim",
        opts = {},
    },
    {
        "m4xshen/smartcolumn.nvim",
        config = smartcolumn_config,
    },
    {
        "famiu/bufdelete.nvim",
    },
}

Module.activate = function() end

return Module
