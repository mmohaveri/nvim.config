return {
    {
        "ThePrimeagen/vim-be-good",
        lazy = true,
        config = false,
    },
    {
        "kylechui/nvim-surround",
        version = "*",
        event = {
            "BufReadPre",
            "BufNewFile",
        },
        config = true,
    },
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        opts = {
            preset = "helix",
        },
    },
}
