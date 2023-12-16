local options = {noremap = true, silent = true}
local keymap = vim.keymap.set


return {
    {
        "famiu/bufdelete.nvim",
        config = function ()
            keymap("n", "<leader>d", ":Bdelete <CR>", options)
        end
    },
}

