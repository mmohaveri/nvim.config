return {
    {
        "MeanderingProgrammer/render-markdown.nvim",
        ft = "markdown",
        dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
        opts = {},
    },
    {
        "toppair/peek.nvim",
        ft = "markdown",
        build = "deno task --quiet build:fast",
        opts = {
            auto_load = true,
            close_on_bdelete = true,
            syntax = true,
            theme = "dark",
            update_on_change = true,
            app = { "brave-browser", "--new-window" },
            filetype = { "markdown" },
        },
        init = function()
            vim.api.nvim_create_user_command("MKPeekOpen", function() require("peek").open() end, {
                desc = "Open markdown preview window in browser",
            })
            vim.api.nvim_create_user_command("MKPeekClose", function() require("peek").close() end, {

                desc = "Closes markdown preview window",
            })
        end,
    },
}
