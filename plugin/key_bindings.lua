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
local function goto_next_diagnostic() vim.diagnostic.goto_next() end
local function goto_prev_diagnostic() vim.diagnostic.goto_prev() end
local function goto_next_error() vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.ERROR }) end
local function goto_prev_error() vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity.ERROR }) end
local function goto_next_git_change() require("gitsigns").next_hunk() end
local function goto_prev_git_change() require("gitsigns").prev_hunk() end
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
local _size_change = "2"
local _mod_key = "C"

if vim.uv.os_uname().sysname == "Darwin" then _mod_key = "M" end

nmap("<" .. _mod_key .. "-Up>", ":resize +" .. _size_change .. "<CR>", "Increase window hight")
nmap("<" .. _mod_key .. "-Down>", ":resize -" .. _size_change .. "<CR>", "Decrease window hight")
nmap("<" .. _mod_key .. "-Right>", ":vertical resize +" .. _size_change .. "<CR>", "Increase window width")
nmap("<" .. _mod_key .. "-Left>", ":vertical resize -" .. _size_change .. "<CR>", "Decrease window width")

-- Diagnostics
nmap("<leader><leader>t", vim.lsp.buf.hover, "Show type hint in floating window")
nmap("<leader>e", vim.diagnostic.open_float, "Show diagnostics in floating window")
nmap("]d", goto_next_diagnostic, "Go to next diagnostic")
nmap("[d", goto_prev_diagnostic, "Go to previous diagnostic")
nmap("]e", goto_next_error, "Go to next error diagnostic")
nmap("]e", goto_prev_error, "Go to previous error diagnostic")

nmap("]c", goto_next_git_change, "Go to next hunk")
nmap("[c", goto_prev_git_change, "Go to previous hunk")

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
