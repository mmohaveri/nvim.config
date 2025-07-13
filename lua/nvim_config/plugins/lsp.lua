return {
    {
        "mmohaveri/EZ-LSP.nvim",
        event = {
            "BufReadPre",
            "BufNewFile",
        },
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
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
                "fga-lsp",
            },
        },
    },
    {
        "antosha417/nvim-lsp-file-operations",
        event = "VeryLazy",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-tree.lua",
        },
        config = true,
    },
}
