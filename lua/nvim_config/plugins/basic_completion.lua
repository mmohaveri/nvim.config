return {
    {
        "JoosepAlviste/nvim-ts-context-commentstring",
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
        },
        opts = {
            enable_autocmd = false,
        },
        config = function(_, opts)
            require("ts_context_commentstring").setup(opts)

            local vim_original_get_option = vim.filetype.get_option
            vim.filetype.get_option = function(filetype, option)
                if option == "commentstring" then
                    return require("ts_context_commentstring.internal").calculate_commentstring()
                else
                    return vim_original_get_option(filetype, option)
                end
            end
        end,
    },
    {
        "windwp/nvim-ts-autotag",
        version = "*",
        event = {
            "BufReadPre",
            "BufNewFile",
        },
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
        },
        config = true,
    },
    {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        config = true,
    },
}
