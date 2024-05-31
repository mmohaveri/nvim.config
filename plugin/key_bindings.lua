local key_bindings = require("utils.key_bindings")
local map = key_bindings.map
local nmap = key_bindings.nmap
local get_nmap_for_buffer = key_bindings.get_nmap_for_buffer

local buffer_manage_ui = require("buffer_manager.ui")
local telescope = require("telescope")
local telescope_builtin = require("telescope.builtin")
local ufo = require("ufo")

local show_file_tree = vim.cmd.NvimTreeToggle -- ":Lex<CR>"
local delete_buffer = ":Bdelete <CR>" -- ":bdelete <CR>"
local list_buffers = buffer_manage_ui.toggle_quick_menu -- ":buffers"
local show_refrences = telescope_builtin.lsp_references -- vim.lsp.buf.references
local show_definitions = telescope_builtin.lsp_definitions -- vim.lsp.buf.definition
local show_implementations = telescope_builtin.lsp_implementations -- vim.lsp.buf.implementation
local show_type_definitions = telescope_builtin.lsp_type_definitions

nmap("<leader>ft", show_file_tree, "Show file tree")
nmap("<leader>s", vim.cmd.vsplit, "Split vertically")

-- Buffer navigation
nmap("<leader>l", ":bnext<CR>", "Go to next buffer")
nmap("<leader>h", ":bprevious<CR>", "Go to previous buffer")
nmap("<leader>d", delete_buffer, "Delete current buffer")
nmap("<leader>b", list_buffers, "List open buffers")

-- Window navigation
nmap("<leader><leader>h", "<C-w>h", "Move one window left")
nmap("<leader><leader>j", "<C-w>j", "Move one window down")
nmap("<leader><leader>k", "<C-w>k", "Move one window up")
nmap("<leader><leader>l", "<C-w>l", "Move one window right")

-- map("<leader>left", "<C-w>H")
-- map("<leader>down", "<C-w>J")
-- map("<leader>up", "<C-w>K")
-- map("<leader>right", "<C-w>L")

-- Window resize
if vim.loop.os_uname().sysname == "Darwin" then
    nmap("<M-Up>", ":resize +2<CR>", "Increase window hight")
    nmap("<M-Down>", ":resize -2<CR>", "Decrease window hight")
    nmap("<M-Left>", ":vertical resize +2<CR>", "Increase window width")
    nmap("<M-Right>", ":vertical resize -2<CR>", "Decrease window width")
else
    nmap("<C-Up>", ":resize +2<CR>", "Increase window hight")
    nmap("<C-Down>", ":resize -2<CR>", "Decrease window hight")
    nmap("<C-Left>", ":vertical resize +2<CR>", "Increase window width")
    nmap("<C-Right>", ":vertical resize -2<CR>", "Decrease window width")
end

-- Diagnostics
nmap("<leader><leader>t", vim.lsp.buf.hover, "Show type hint in floating window")
nmap("<leader>e", vim.diagnostic.open_float, "Show diagnostics in floating window")
nmap("]d", vim.diagnostic.goto_next, "Go to next diagnostic")
nmap("[d", vim.diagnostic.goto_prev, "Go to previous diagnostic")

map("t", "<esc>", [[<C-\><C-n>]], "Switch to normal mode from terminal mode")

local function peek_folded_lines_under_cursor()
    if not ufo.peekFoldedLinesUnderCursor() then vim.lsp.buf.hover() end
end
-- map("zR", ufo.openAllFolds)
-- map("zM", ufo.closeAllFolds)
-- map("zr", ufo.openFoldsExceptKinds)
-- map("zm", ufo.closeFoldsWith)
nmap("L", peek_folded_lines_under_cursor, "Peek folded lines under the cursor in floating window")

nmap("<leader>`", ":Cheatsheet<CR>", "Show cheatsheet")

nmap("<leader>F", ":FormatWriteLock<CR>", "Format document")

nmap("<leader>t", telescope.extensions.picker_list.picker_list, "Show telescope's pickers list")
nmap("<leader>ff", telescope_builtin.find_files, "Show telescope's find files")
nmap("<leader>rt", telescope_builtin.resume, "Resume last telescope picker")

---@param bufnr integer
function _G.set_lsp_keymaps_for_buffer(bufnr)
    local nmapb = get_nmap_for_buffer(bufnr)

    nmapb("gR", show_refrences, "show references")
    nmapb("gD", vim.lsp.buf.declaration, "Go to declaration")
    nmapb("gd", show_definitions, "Show definitions")
    nmapb("gi", show_implementations, "Show implementations")
    nmapb("gt", show_type_definitions, "Show type definitions")

    nmapb("K", vim.lsp.buf.hover, "Show documentation for what is under cursor")
    nmapb("<C-k>", vim.lsp.buf.signature_help, "Show signature's help")

    nmapb("<leader>ca", vim.lsp.buf.code_action, "See available code actions")

    nmapb("[d", vim.diagnostic.goto_prev, "Go to previous diagnostic")
    nmapb("gl", vim.diagnostic.open_float, "Show line diagnostics")
    nmapb("]d", vim.diagnostic.goto_next, "Go to next diagnostic")
    nmapb("<leader>D", telescope_builtin.diagnostics, "Show buffer diagnostics")

    nmapb("<leader>rn", vim.lsp.buf.rename, "Smart rename")

    nmapb("<leader>q", vim.diagnostic.setloclist, "")
end
