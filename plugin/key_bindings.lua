local map_for_mode = function(mode, lhs, rhs) vim.keymap.set(mode, lhs, rhs, { noremap = true, silent = true }) end
local map = function(lhs, rhs) map_for_mode("n", lhs, rhs) end

local buffer_manage_ui = require("buffer_manager.ui")
local telescope = require("telescope")
local telescope_builtin = require("telescope.builtin")
local ufo = require("ufo")

map("<leader>ft", vim.cmd.NvimTreeFocus) -- ":Lex<CR>"
map("<leader>s", vim.cmd.vsplit)

-- Buffer navigation
map("<leader>l", ":bnext<CR>")
map("<leader>h", ":bprevious<CR>")
map("<leader>d", ":Bdelete <CR>") -- ":bdelete <CR>"
map("<leader>b", buffer_manage_ui.toggle_quick_menu)

-- Window navigation
map("<leader><leader>h", "<C-w>h")
map("<leader><leader>j", "<C-w>j")
map("<leader><leader>k", "<C-w>k")
map("<leader><leader>l", "<C-w>l")

-- map("<leader>left", "<C-w>H")
-- map("<leader>down", "<C-w>J")
-- map("<leader>up", "<C-w>K")
-- map("<leader>right", "<C-w>L")

-- Window resize
if vim.loop.os_uname().sysname == "Darwin" then
    map("<M-Up>", ":resize +2<CR>")
    map("<M-Down>", ":resize -2<CR>")
    map("<M-Left>", ":vertical resize +2<CR>")
    map("<M-Right>", ":vertical resize -2<CR>")
else
    map("<C-Up>", ":resize +2<CR>")
    map("<C-Down>", ":resize -2<CR>")
    map("<C-Left>", ":vertical resize +2<CR>")
    map("<C-Right>", ":vertical resize -2<CR>")
end

-- Diagnostics
map("<leader><leader>t", vim.lsp.buf.hover)
map("<leader>e", vim.diagnostic.open_float)
map("]d", vim.diagnostic.goto_next)
map("[d", vim.diagnostic.goto_prev)

map_for_mode("t", "<esc>", [[<C-\><C-n>]])

local function peek_folded_lines_under_cursor()
    if not ufo.peekFoldedLinesUnderCursor() then vim.lsp.buf.hover() end
end
-- map("zR", ufo.openAllFolds)
-- map("zM", ufo.closeAllFolds)
-- map("zr", ufo.openFoldsExceptKinds)
-- map("zm", ufo.closeFoldsWith)
map("L", peek_folded_lines_under_cursor)

map("<leader>`", ":Cheatsheet<CR>")

map("<leader>F", ":FormatWriteLock<CR>")

map("<leader>t", telescope.extensions.picker_list.picker_list)
map("<leader>ff", telescope_builtin.find_files)
map("<leader>rt", telescope_builtin.resume)
