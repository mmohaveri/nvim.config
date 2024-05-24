return {
    {
        dir = "~/.config/nvim/local_plugins/lsp_config",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "nvim-telescope/telescope.nvim",
        },
        config = true,
    },
    {
        "mrded/nvim-lsp-notify",
        event = "VeryLazy",
        dependencies = {
            "rcarriga/nvim-notify",
        },
        config = true,
    },
    {
        "antosha417/nvim-lsp-file-operations",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-tree.lua",
        },
        config = true,
    },
}
