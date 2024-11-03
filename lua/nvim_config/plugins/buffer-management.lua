return {
    {
        "famiu/bufdelete.nvim",
        lazy = true,
    },
    {
        "j-morano/buffer_manager.nvim",
        lazy = true,
        opts = {
            short_file_names = false,
            short_term_names = true,
            order_buffers = "lastused:reverse",
        },
    },
}
