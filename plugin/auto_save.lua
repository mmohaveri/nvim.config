local function save_buffer_if_writable()
    local is_not_readonly = not vim.bo.readonly
    local is_untyped_buffer = (vim.bo.buftype == "")
    local has_file_name = (vim.api.nvim_buf_get_name(0) ~= "")

    local is_writable = is_untyped_buffer and is_not_readonly and has_file_name

    if is_writable then vim.api.nvim_command("write") end
end

vim.api.nvim_create_autocmd({
    "BufLeave",
    "FocusLost",
}, {
    pattern = "*",
    callback = save_buffer_if_writable,
})
