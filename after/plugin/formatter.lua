vim.api.nvim_create_autocmd({ "BufWritePost" }, {
    command = ":FormatWriteLock",
})
