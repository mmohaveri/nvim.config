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

local notify_config = {
    render = "wrapped-compact",
    stages = "slide",
    timeout = 5000,
}

Module.plugin_spec = {
    {
        "nvim-lualine/lualine.nvim",
        config = true,
    },
    {
        "m4xshen/smartcolumn.nvim",
        opts = smartcolumn_config,
    },
    {
        "famiu/bufdelete.nvim",
    },
    {
        'stevearc/dressing.nvim',
        config = true,
    },
    {
        "rcarriga/nvim-notify",
        opts = notify_config,
        init = function ()
            vim.notify = require("notify")
        end
    },
}

Module.activate = function() end

return Module
