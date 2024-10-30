return {
    {
        "famiu/bufdelete.nvim",
        keys = {
            "<leader>d",
        },
    },
    {
        "j-morano/buffer_manager.nvim",
        keys = {
            "<leader>b",
        },
        opts = {
            short_file_names = false,
            short_term_names = true,
            order_buffers = "lastused:reverse",
        },
    },
}
