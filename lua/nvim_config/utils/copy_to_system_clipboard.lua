local M = {}

---@param register string
M.CopyToSystemClipboard = function(register)
    local register_name = register ~= "" and register or '"'
    vim.fn.setreg("+", vim.fn.getreg(register_name))
end

M.register_user_command = function()
    vim.api.nvim_create_user_command(
        "CopyToSystemClipboard",
        function(opts) M.CopyToSystemClipboard(opts.args) end,
        { nargs = "?" }
    )
end

return M
