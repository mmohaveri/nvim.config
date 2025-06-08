local event_format = "%f:%l:%c - %m"

return {
    cmd = "npm",
    stdin = true,
    args = {
        "exec",
        "--silent",
        "--yes",
        "--",
        "cspell",
        "lint",
        "--no-color",
        "--no-progress",
        "--no-summary",
        function() return "stdin://" .. vim.api.nvim_buf_get_name(0) end,
    },
    ignore_exitcode = true,
    stream = "stdout",
    parser = function(output)
        local lines = vim.split(output, "\n")
        local qflist = vim.fn.getqflist({ efm = event_format, lines = lines })
        local result = {}
        for _, item in pairs(qflist.items) do
            if item.valid == 1 then
                local message = item.text:match("^%s*(.-)%s*$")
                local word = message:match("%(.*%)")
                local lnum = math.max(0, item.lnum - 1)
                local col = math.max(0, item.col - 1)
                local end_lnum = item.end_lnum > 0 and (item.end_lnum - 1) or lnum
                local end_col = col + word:len() - 2 or col
                local diagnostic = {
                    lnum = lnum,
                    col = col,
                    end_lnum = end_lnum,
                    end_col = end_col,
                    message = message,
                    source = "cspell",
                    severity = vim.diagnostic.severity.INFO,
                }
                table.insert(result, diagnostic)
            end
        end
        return result
    end,
}
