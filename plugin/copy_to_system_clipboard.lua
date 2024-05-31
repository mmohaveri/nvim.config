---@param register string
local function CopyToSystemClipboard(register)
    local register_name = register ~= "" and register or '"'
    vim.fn.setreg("*", vim.fn.getreg(register_name))
end

vim.api.nvim_create_user_command(
    "CopyToSystemClipboard",
    function(opts) CopyToSystemClipboard(opts.args) end,
    { nargs = "?" }
)
