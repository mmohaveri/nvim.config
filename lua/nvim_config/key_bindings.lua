local options = { noremap = true, silent = true }
local keymap = vim.keymap.set

vim.g.mapleader = " "

keymap("n", "<leader>ft", ":Lex<CR>")
keymap("n", "<leader>s", vim.cmd.vsplit)

-- Buffer navigation
keymap("n", "<leader>l", ":bnext<CR>", options)
keymap("n", "<leader>h", ":bprevious<CR>", options)
keymap("n", "<leader>d", ":bdelete <CR>", options)

-- Window navigation
keymap("n", "<leader><leader>h", "<C-w>h", options)
keymap("n", "<leader><leader>j", "<C-w>j", options)
keymap("n", "<leader><leader>k", "<C-w>k", options)
keymap("n", "<leader><leader>l", "<C-w>l", options)

-- keymap("n", "<leader>left", "<C-w>H", options)
-- keymap("n", "<leader>down", "<C-w>J", options)
-- keymap("n", "<leader>up", "<C-w>K", options)
-- keymap("n", "<leader>right", "<C-w>L", options)

-- Window resize
if vim.loop.os_uname().sysname == "Darwin" then
    keymap("n", "<M-Up>", ":resize +2<CR>", options)
    keymap("n", "<M-Down>", ":resize -2<CR>", options)
    keymap("n", "<M-Left>", ":vertical resize +2<CR>", options)
    keymap("n", "<M-Right>", ":vertical resize -2<CR>", options)
else
    keymap("n", "<C-Up>", ":resize +2<CR>", options)
    keymap("n", "<C-Down>", ":resize -2<CR>", options)
    keymap("n", "<C-Left>", ":vertical resize +2<CR>", options)
    keymap("n", "<C-Right>", ":vertical resize -2<CR>", options)
end

-- Global diagnostics

keymap("n", "<leader><leader>t", vim.lsp.buf.hover)
keymap("n", "<leader>e", vim.diagnostic.open_float)
