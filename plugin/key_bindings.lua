local options = { noremap = true, silent = true }
local keymap = vim.keymap.set

local buffer_manage_ui = require("buffer_manager.ui")
local telescope = require("telescope")
local telescope_builtin = require("telescope.builtin")

-- keymap("n", "<leader>ft", ":Lex<CR>", options)
keymap("n", "<leader>s", vim.cmd.vsplit, options)

-- Buffer navigation
keymap("n", "<leader>l", ":bnext<CR>", options)
keymap("n", "<leader>h", ":bprevious<CR>", options)
-- keymap("n", "<leader>d", ":bdelete <CR>", options)
keymap("n", "<leader>d", ":Bdelete <CR>", options)
keymap("n", "<leader>b", buffer_manage_ui.toggle_quick_menu, options)

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

keymap("n", "<leader><leader>t", vim.lsp.buf.hover, options)
keymap("n", "<leader>e", vim.diagnostic.open_float, options)
keymap("n", "]d", vim.diagnostic.goto_next, options)
keymap("n", "[d", vim.diagnostic.goto_prev, options)

keymap("t", "<esc>", [[<C-\><C-n>]], options)

local function peek_folded_lines_under_cursor()
    local winid = require("ufo").peekFoldedLinesUnderCursor()
    if not winid then vim.lsp.buf.hover() end
end
-- keymap('n', 'zR', require('ufo').openAllFolds)
-- keymap('n', 'zM', require('ufo').closeAllFolds)
-- keymap('n', 'zr', require('ufo').openFoldsExceptKinds)
-- keymap('n', 'zm', require('ufo').closeFoldsWith)

keymap("n", "L", peek_folded_lines_under_cursor, options)

keymap("n", "<leader>`", ":Cheatsheet<CR>", options)

keymap("n", "<leader>F", ":FormatWriteLock<CR>", options)

keymap("n", "<leader>ft", vim.cmd.NvimTreeFocus, options)

keymap("n", "<leader>t", telescope.extensions.picker_list.picker_list, options)
keymap("n", "<leader>ff", telescope_builtin.find_files, options)
keymap("n", "<leader>rt", telescope_builtin.resume, options)
