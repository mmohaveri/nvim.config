return {
    {
        "ThePrimeagen/vim-be-good",
        event = {},
       config = false,
    },
    {
        "sudormrfbin/cheatsheet.nvim",
        dependencies = {
            "nvim-telescope/telescope.nvim",
            "nvim-lua/popup.nvim",
            "nvim-lua/plenary.nvim",
        },
        opts = {
            bundled_cheatsheets = false,
            bundled_plugin_cheatsheets = false,
        }
    },
}

