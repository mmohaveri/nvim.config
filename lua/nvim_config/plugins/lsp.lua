return {
    {
        "mmohaveri/EZ-LSP.nvim",
        event = {
            "BufReadPre",
            "BufNewFile",
        },
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "nvim-telescope/telescope.nvim",
        },
        opts = {
            servers = {
                "css",
                "eslint",
                "go",
                "html",
                "json",
                "lua",
                "pyright",
                "ruff",
                "rust",
                "tex",
                "toml",
                "typescript",
                "vue",
                "yaml",
                "terraform",
            },
        },
    },
    {
        "mrded/nvim-lsp-notify",
        event = "LspAttach",
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
