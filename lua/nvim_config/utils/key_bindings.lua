local M = {}

-- n = "Normal",
-- v = "Visual & Select",
-- x = "Visual",
-- s = "Select",
-- o = "Operator Pending",
-- "" = "Normal, Visual, Select, Operator Pending",
-- "!" = "Insert & Command",
-- ic = "Insert & Command",
-- i = "Insert",
-- l = "Insert, Command, Lang-Arg",
-- c = "Command",
-- t = "Terminal",

--- @param mode "n" | "v" | "x" | "s" | "o" | "" | "!" | "ic" | "i" | "l" | "c" | "t"
--- @param lhs string
--- @param rhs string | function
--- @param desc string | nil
--- @param bufnr integer | nil
function M.map(mode, lhs, rhs, desc, bufnr)
    local opts = { noremap = true, silent = true, desc = desc, buffer = bufnr }

    vim.keymap.set(mode, lhs, rhs, opts)
end

--- @param mode "n" | "v" | "x" | "s" | "o" | "" | "!" | "ic" | "i" | "l" | "c" | "t"
--- @param lhs string
--- @param rhs string | function
--- @param desc string | nil
function M.global_map(mode, lhs, rhs, desc)
    local opts = { noremap = true, silent = true, desc = desc, buffer = nil }

    vim.keymap.set(mode, lhs, rhs, opts)
end

--- @param mode "n" | "v" | "x" | "s" | "o" | "" | "!" | "ic" | "i" | "l" | "c" | "t"
--- @param lhs string
--- @param rhs string | function
--- @param desc string | nil
--- @param bufnr integer
function M.buffer_map(mode, lhs, rhs, desc, bufnr)
    local opts = { noremap = true, silent = true, desc = desc, buffer = bufnr }

    vim.keymap.set(mode, lhs, rhs, opts)
end

return M
