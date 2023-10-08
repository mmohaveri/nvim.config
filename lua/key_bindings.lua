local options = {noremap = true, silent = true}
local keymap = vim.keymap.set
local telescope_builtin = require("telescope.builtin")

vim.g.mapleader = " "

keymap("n", "<leader>ls", vim.cmd.NvimTreeFocus)
keymap("n", "<leader>s", vim.cmd.vsplit)

-- Basic navigation
-- Buffer navigation
keymap("n", "<leader>l", ":bnext<CR>", options)
keymap("n", "<leader>h", ":bprevious<CR>", options)
keymap("n", "<leader>d", ":Bdelete <CR>", options)
keymap("n", "<leader>dd", ":%bd | NvimTreeFocus <CR>", options)

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
keymap("n", "<C-Up>", ":resize +2<CR>", options)
keymap("n", "<C-Down>", ":resize -2<CR>", options)
keymap("n", "<C-Left>", ":vertical resize +2<CR>", options)
keymap("n", "<C-Right>", ":vertical resize -2<CR>", options)

-- telescope
keymap("n", "<leader>t", ":Telescope<CR>", {})
keymap('n', "<leader>lg", telescope_builtin.live_grep, {})
keymap("n", "<leader>ff", telescope_builtin.find_files, {})
keymap("n", "<leader>fgf", telescope_builtin.git_files, {})
keymap("n", "<leader>fb", telescope_builtin.buffers, {})
keymap("n", "<leader>tr", telescope_builtin.resume, {})

-- keymap('n', '<leader>fh', telescope_builtin.help_tags, {})
