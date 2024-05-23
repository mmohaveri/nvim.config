local options = { noremap = true, silent = true }
local keymap = vim.keymap.set

return {
    {
        "famiu/bufdelete.nvim",
        config = function() keymap("n", "<leader>d", ":Bdelete <CR>", options) end,
    },
    {
        "j-morano/buffer_manager.nvim",
        opts = {
            short_file_names = false,
            short_term_names = true,
            order_buffers = "lastused:reverse",
        },
    },
}
