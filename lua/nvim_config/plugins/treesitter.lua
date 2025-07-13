local fga_ts = require("nvim_config.ft.fga")

return {
    {
        "nvim-treesitter/nvim-treesitter",
        branch = "master",
        event = {
            "VeryLazy",
        },
        lazy = vim.fn.argc(-1) == 0,
        build = ":TSUpdate",
        main = "nvim-treesitter.configs",
        opts = {
            ensure_installed = require("nvim_config.treesitter.parsers"),
            -- IIUC, custom parsers needs to be installed manually
            -- To install, run `:TSInstall <lang_name>`
            -- Don't forget to install parser queries as well
            ignore_install = {
                "fga",
            },
            auto_install = true,
            sync_install = true,
            highlight = {
                enable = true,
                disable = {},
                additional_vim_regex_highlighting = {},
            },
            incremental_selection = {
                enable = false,
            },
            indent = {
                enable = true,
                disable = {},
            },
        },
        init = function()
            require("nvim_config.treesitter.utils").register_ts_runtime_path()
            fga_ts.register_filetype()
            fga_ts.register_ts_parser()
        end,
    },
}
