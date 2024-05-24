local M = {}

--- @param mode "n" | "i" | "v" | "x" | "t"
--- @param lhs string
--- @param rhs string | function
--- @param desc string | nil
--- @param bufnr integer | nil
function M.map(mode, lhs, rhs, desc, bufnr)
    local opts = { noremap = true, silent = true, desc = desc, buffer = bufnr }

    vim.keymap.set(mode, lhs, rhs, opts)
end

--- @param lhs string
--- @param rhs string | function
--- @param desc string | nil
function M.nmap(lhs, rhs, desc) M.map("n", lhs, rhs, desc) end

--- @param bufnr integer
function M.get_nmap_for_buffer(bufnr)
    --- @param lhs string
    --- @param rhs string | function
    --- @param desc string | nil
    return function(lhs, rhs, desc) M.map("n", lhs, rhs, desc, bufnr) end
end

return M
