local M = {}

M.save_buffer_if_writable = function()
    local bufnr = vim.api.nvim_get_current_buf() 

    local buf_name = vim.api.nvim_buf_get_name(bufnr)
    local buf_type = vim.api.nvim_get_option_value("buftype", { buf = bufnr })
    local is_modified = vim.api.nvim_get_option_value("modified", { buf = bufnr })
    local is_readonly = vim.api.nvim_get_option_value("readonly", { buf = bufnr })

    local is_untyped_buffer = (buf_type == "")
    local has_file_name = (buf_name ~= "")
    local is_writable = is_untyped_buffer and not is_readonly and has_file_name and is_modified

    if is_writable then
        local was_success, err = pcall(vim.api.nvim_command, "write")

        if was_success then return end

        vim.notify("Failed to autosave `" .. buf_name .. "`: " .. err, vim.log.levels.ERROR)
    end
end

---@param events string[] | nil
M.register_autocmd = function(events)
    if events == nil then events = {
        "BufLeave",
        "FocusLost",
    } end

    vim.api.nvim_create_autocmd(events, {
        pattern = "*",
        callback = M.save_buffer_if_writable,
    })
end

return M
