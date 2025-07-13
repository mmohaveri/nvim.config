return {
    get_fold_text = function()
        local first_line = vim.fn.getline(vim.v.foldstart)
        local last_line = vim.fn.getline(vim.v.foldend)
        local line_count = vim.v.foldend - vim.v.foldstart + 1

        -- Remove leading whitespace from first line for cleaner display
        last_line = last_line:gsub("^%s*", "")

        -- Create the single-line display with separators
        local fold_symbol = " ▼ " .. line_count .. " lines folded ▼ "

        return first_line .. fold_symbol .. last_line
    end,
}
