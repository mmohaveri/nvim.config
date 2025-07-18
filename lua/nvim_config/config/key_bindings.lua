local M = {}

local snacks = require("snacks")
local picker = snacks.picker
local _ERROR = vim.diagnostic.severity.ERROR

---comment jump shorthand
---@param count integer
---@param severity? vim.diagnostic.Severity | nil
local function jump(count, severity) vim.diagnostic.jump({ count = count, float = true, severity = severity }) end

M.set_keybindings = function()
    local global_map = require("nvim_config.utils.key_bindings").global_map

    -- Buffer navigation
    global_map("n", "<leader>l", vim.cmd.bnext, "Go to next buffer")
    global_map("n", "<leader>h", vim.cmd.bprevious, "Go to previous buffer")
    global_map("n", "<leader>d", snacks.bufdelete.delete, "Delete current buffer (without changing layout)")
    global_map("n", "<leader>b", snacks.picker.buffers, "List open buffers")

    -- Window navigation
    global_map("n", "<leader><leader>h", function() vim.cmd.wincmd("h") end, "Move one window left")
    global_map("n", "<leader><leader>j", function() vim.cmd.wincmd("j") end, "Move one window down")
    global_map("n", "<leader><leader>k", function() vim.cmd.wincmd("k") end, "Move one window up")
    global_map("n", "<leader><leader>l", function() vim.cmd.wincmd("l") end, "Move one window right")
    global_map("n", "<leader>s", vim.cmd.vsplit, "Split vertically")

    -- Window resize
    local _size_change = "2"
    local _mod_key = "C"
    if vim.uv.os_uname().sysname == "Darwin" then _mod_key = "M" end

    global_map("n", "<" .. _mod_key .. "-Up>", ":resize +" .. _size_change .. "<CR>", "Increase window hight")
    global_map("n", "<" .. _mod_key .. "-Down>", ":resize -" .. _size_change .. "<CR>", "Decrease window hight")
    global_map(
        "n",
        "<" .. _mod_key .. "-Right>",
        ":vertical resize +" .. _size_change .. "<CR>",
        "Increase window width"
    )
    global_map(
        "n",
        "<" .. _mod_key .. "-Left>",
        ":vertical resize -" .. _size_change .. "<CR>",
        "Decrease window width"
    )

    -- Diagnostics & in buffer navigation
    global_map("n", "<leader>e", vim.diagnostic.open_float, "Show line diagnostics")
    global_map("n", "nd", function() jump(1) end, "Go to next diagnostic")
    global_map("n", "bd", function() jump(-1) end, "Go to previous diagnostic")
    global_map("n", "ne", function() jump(1, _ERROR) end, "Go to next error diagnostic")
    global_map("n", "be", function() jump(-1, _ERROR) end, "Go to previous error diagnostic")
    -- global_map("n", "<leader>l", vim.diagnostic.setloclist, "Add diagnostics to the location list")

    global_map("n", "ngc", function() require("gitsigns").next_hunk() end, "Go to next git hunk")
    global_map("n", "bgc", function() require("gitsigns").prev_hunk() end, "Go to previous git hunk")

    -- Pickers
    global_map("", "<C-j>", picker.command_palette, "Show pickers list")
    global_map("", "<C-h>", picker.resume, "Resume last picker")
    global_map("n", "<leader>?", picker.keymaps, "List all Keymaps")
    global_map("n", "<leader>ff", picker.files, "Show find files")
    global_map(
        "n",
        "<leader>faf",
        function() picker.files({ hidden = true, ignored = true }) end,
        "Show find all files"
    )
    global_map("n", "<leader>ft", picker.explorer, "Show files tree")
    global_map("n", "<leader>fw", picker.grep_word, "live grep word under the cursor")
    global_map("n", "U", picker.undo, "Show undo tree")
end

-- LSP Keymaps
---@param bufnr integer
function _G.ez_lsp_set_lsp_keymaps_for_buffer(bufnr)
    local buffer_map = require("nvim_config.utils.key_bindings").buffer_map

    buffer_map("n", "gR", picker.lsp_references, "show references for what's under the cursor", bufnr)
    buffer_map("n", "gD", picker.lsp_declarations, "Go to declaration of what's under the cursor", bufnr)
    buffer_map("n", "gd", picker.lsp_definitions, "Go to definitions of what's under the cursor", bufnr)
    buffer_map("n", "gi", picker.lsp_implementations, "Show implementations for what's under the cursor", bufnr)
    buffer_map("n", "gt", picker.lsp_type_definitions, "Show type definitions for what's under the cursor", bufnr)

    -- Calling the next two functions twice will go inside the hover
    buffer_map("n", "K", vim.lsp.buf.hover, "Show documentation for what's under the cursor", bufnr)
    buffer_map("n", "<C-k>", vim.lsp.buf.signature_help, "Show signature help for what's under the cursor", bufnr)

    buffer_map("n", "<leader>ca", vim.lsp.buf.code_action, "List available code actions", bufnr)
    buffer_map("n", "<leader>rn", vim.lsp.buf.rename, "Rename symbol under the cursor", bufnr)
end

return M
