local function save_buffer_if_writable()
    if (not vim.bo.readonly) and (vim.bo.buftype == "") then
        vim.api.nvim_command(":w")
    end
end

vim.api.nvim_create_autocmd("BufLeave", {
    pattern = "*",
    callback = save_buffer_if_writable,
})

vim.api.nvim_create_autocmd("FocusLost", {
    pattern = "*",
    callback = save_buffer_if_writable,
})
