local Module = {}

local winbar_config = {
    enabled = true,

    show_file_path = true,
    show_symbols = true,

    colors = {
        path = '', -- You can customize colors like #c946fd
        file_name = '',
        symbols = '',
    },

    icons = {
        file_icon_default = '',
        seperator = '>',
        editor_state = '●',
        lock_icon = '',
    },

    exclude_filetype = {
        'help',
        'startify',
        'dashboard',
        'packer',
        'neogitstatus',
        'NvimTree',
        'Trouble',
        'alpha',
        'lir',
        'Outline',
        'spectre_panel',
        'toggleterm',
        'qf',
    }
}

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
        "fgheng/winbar.nvim",
        config = winbar_config,
    },
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
