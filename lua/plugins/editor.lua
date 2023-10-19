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

local lsp_notify_config = {
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
    {
        'stevearc/dressing.nvim',
        opts = {},
    },
    {
        "rcarriga/nvim-notify",
        config = notify_config,
    },
}

Module.activate = function() end

return Module
