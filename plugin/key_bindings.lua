local key_bindings = require("utils.key_bindings")
local map = key_bindings.map
local nmap = key_bindings.nmap
local get_nmap_for_buffer = key_bindings.get_nmap_for_buffer

local show_file_tree = vim.cmd.NvimTreeToggle -- ":Lex<CR>"
local function delete_buffer() require("bufdelete").bufdelete(0) end -- ":bdelete <CR>"
local function list_buffers() require("buffer_manager.ui").toggle_quick_menu() end -- ":buffers"
local function show_references() require("telescope.builtin").lsp_references() end -- vim.lsp.buf.references
local function show_definitions() require("telescope.builtin").lsp_definitions() end -- vim.lsp.buf.definition
local function show_implementations() require("telescope.builtin").lsp_implementations() end -- vim.lsp.buf.implementation
local function show_type_definitions() require("telescope.builtin").lsp_type_definitions() end
local function show_diagnostic() require("telescope.builtin").diagnostics() end
local function show_find_files() require("telescope.builtin").find_files() end
local function resume_last_telescope_picker() require("telescope.builtin").resume() end
local function show_pickers_list() require("telescope").extensions.picker_list.picker_list() end
local function live_grep_word_under_cursor() require("utils.fast_live_grep").word_under_cursor() end
local function show_which_key_help() require("which-key").show({ global = false }) end
local function toggle_termimnal() require("toggleterm").toggle() end
local function add_to_harpoon() require("harpoon"):list():add() end
local function toggle_harpoon_quick_menu()
    local harpoon = require("harpoon")
    harpoon.ui:toggle_quick_menu(harpoon:list())
end

nmap("<leader>ft", show_file_tree, "Show file tree")
nmap("<leader>s", vim.cmd.vsplit, "Split vertically")

-- Buffer navigation
nmap("<leader>l", ":bnext<CR>", "Go to next buffer")
nmap("<leader>h", ":bprevious<CR>", "Go to previous buffer")
nmap("<leader>d", delete_buffer, "Delete current buffer")
nmap("<leader>B", list_buffers, "List open buffers")
nmap("<leader>a", add_to_harpoon, "add the current buffer to harpoon")
nmap("<leader>b", toggle_harpoon_quick_menu, "toggle harpoon quick menu")

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
if vim.uv.os_uname().sysname == "Darwin" then
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

-- Using <esc> will prevents us from entering shell's VI mode
map("t", [[<C-n>]], [[<C-\><C-n>]], "Switch to normal mode from terminal mode")

local function peek_folded_lines_under_cursor()
    local ufo = require("ufo")
    if not ufo.peekFoldedLinesUnderCursor() then vim.lsp.buf.hover() end
end
-- map("zR", ufo.openAllFolds)
-- map("zM", ufo.closeAllFolds)
-- map("zr", ufo.openFoldsExceptKinds)
-- map("zm", ufo.closeFoldsWith)
nmap("L", peek_folded_lines_under_cursor, "Peek folded lines under the cursor in floating window")

nmap("<leader>F", ":FormatWriteLock<CR>", "Format document")

nmap("<leader>t", show_pickers_list, "Show telescope's pickers list")
nmap("<leader>ff", show_find_files, "Show telescope's find files")
nmap("<leader>rt", resume_last_telescope_picker, "Resume last telescope picker")

---@param bufnr integer
function _G.ez_lsp_set_lsp_keymaps_for_buffer(bufnr)
    local nmapb = get_nmap_for_buffer(bufnr)

    nmapb("gR", show_references, "show references")
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
    nmapb("<leader>D", show_diagnostic, "Show buffer diagnostics")

    nmapb("<leader>rn", vim.lsp.buf.rename, "Smart rename")

    nmapb("<leader>q", vim.diagnostic.setloclist, "")
end

nmap("<leader>fw", live_grep_word_under_cursor, "live grep word under the cursor")

nmap("<leader>?", show_which_key_help, "Buffer Local Keymaps (which-key)")

nmap([[<C-\>]], toggle_termimnal, "Open/Close terminal window")
map("i", [[<C-\>]], toggle_termimnal, "Open/Close terminal window")
map("t", [[<C-\>]], toggle_termimnal, "Open/Close terminal window")
