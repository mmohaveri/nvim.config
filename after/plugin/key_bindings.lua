local key_bindings = require("nvim_config.utils.key_bindings")
local imap = key_bindings.imap
local nmap = key_bindings.nmap
local get_nmap_for_buffer = key_bindings.get_nmap_for_buffer

local snacks = require("snacks")
local picker = snacks.picker
local _ERROR = vim.diagnostic.severity.ERROR
local jump = vim.diagnostic.jump

local function add_to_harpoon() require("harpoon"):list():add() end
local function toggle_harpoon_quick_menu()
    local harpoon = require("harpoon")
    harpoon.ui:toggle_quick_menu(harpoon:list())
end

-- Buffer navigation
nmap("<leader>l", vim.cmd.bnext, "Go to next buffer")
nmap("<leader>h", vim.cmd.bprevious, "Go to previous buffer")
nmap("<leader>d", snacks.bufdelete.delete, "Delete current buffer (without changing layout)")
nmap("<leader>B", snacks.picker.buffers, "List open buffers")

-- Buffer navigation
nmap("<leader>a", add_to_harpoon, "add the current buffer to harpoon")
nmap("<leader>b", toggle_harpoon_quick_menu, "toggle harpoon quick menu")

-- Window navigation
nmap("<leader><leader>h", function() vim.cmd.wincmd("h") end, "Move one window left")
nmap("<leader><leader>j", function() vim.cmd.wincmd("j") end, "Move one window down")
nmap("<leader><leader>k", function() vim.cmd.wincmd("k") end, "Move one window up")
nmap("<leader><leader>l", function() vim.cmd.wincmd("l") end, "Move one window right")
nmap("<leader>s", vim.cmd.vsplit, "Split vertically")

-- Window resize
local _size_change = "2"
local _mod_key = "C"
if vim.uv.os_uname().sysname == "Darwin" then _mod_key = "M" end

nmap("<" .. _mod_key .. "-Up>", ":resize +" .. _size_change .. "<CR>", "Increase window hight")
nmap("<" .. _mod_key .. "-Down>", ":resize -" .. _size_change .. "<CR>", "Decrease window hight")
nmap("<" .. _mod_key .. "-Right>", ":vertical resize +" .. _size_change .. "<CR>", "Increase window width")
nmap("<" .. _mod_key .. "-Left>", ":vertical resize -" .. _size_change .. "<CR>", "Decrease window width")

-- Diagnostics & in buffer navigation
nmap("<leader>e", vim.diagnostic.open_float, "Show line diagnostics")
nmap("nd", function() jump({ count = 1, float = true }) end, "Go to next diagnostic")
nmap("bd", function() jump({ count = -1, float = true }) end, "Go to previous diagnostic")
nmap("ne", function() jump({ count = 1, severity = _ERROR, float = true }) end, "Go to next error diagnostic")
nmap("be", function() jump({ count = -1, severity = _ERROR, float = true }) end, "Go to previous error diagnostic")
-- nmap("<leader>l", vim.diagnostic.setloclist, "Add diagnostics to the location list")

nmap("ngc", function() require("gitsigns").next_hunk() end, "Go to next git hunk")
nmap("bgc", function() require("gitsigns").prev_hunk() end, "Go to previous git hunk")

-- Pickers
nmap("<C-j>", picker.pick, "Show pickers list")
imap("<C-j>", picker.pick, "Show pickers list")
nmap("<C-h>", picker.resume, "Resume last picker")
imap("<C-h>", picker.resume, "Resume last picker")
nmap("<leader>?", function() picker.keymaps({ layout = "vscode" }) end, "List all Keymaps")
nmap("<leader>ff", picker.files, "Show find files")
nmap("<leader>faf", function() picker.files({ hidden = true, ignored = true }) end, "Show find all files")
nmap("<leader>ft", function() picker.explorer({ jump = { close = true } }) end, "Show files tree")
nmap("<leader>fw", picker.grep_word, "live grep word under the cursor")
nmap("U", picker.undo, "Show undo tree")

-- LSP Keymaps
---@param bufnr integer
function _G.ez_lsp_set_lsp_keymaps_for_buffer(bufnr)
    local nmapb = get_nmap_for_buffer(bufnr)

    nmapb("gR", picker.lsp_references, "show references for what's under the cursor")
    nmapb("gD", picker.lsp_declarations, "Go to declaration of what's under the cursor")
    nmapb("gd", picker.lsp_definitions, "Go to definitions of what's under the cursor")
    nmapb("gi", picker.lsp_implementations, "Show implementations for what's under the cursor")
    nmapb("gt", picker.lsp_type_definitions, "Show type definitions for what's under the cursor")

    -- Calling the next two functions twice will go inside the hover
    nmapb("K", vim.lsp.buf.hover, "Show documentation for what's under the cursor")
    nmapb("<C-k>", vim.lsp.buf.signature_help, "Show signature help for what's under the cursor")

    nmapb("<leader>ca", vim.lsp.buf.code_action, "List available code actions")
    nmapb("<leader>rn", vim.lsp.buf.rename, "Rename symbol under the cursor")
end
