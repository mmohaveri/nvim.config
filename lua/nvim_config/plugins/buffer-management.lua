return {
    {
        "famiu/bufdelete.nvim",
        lazy = true,
    },
    {
        "j-morano/buffer_manager.nvim",
        lazy = true,
        opts = {
            width = 100,
            short_file_names = false,
            short_term_names = true,
            order_buffers = "lastused:reverse",
        },
    },
    {
        "ThePrimeagen/harpoon",
        lazy = true,
        branch = "harpoon2",
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
        config = true,
    },
}
