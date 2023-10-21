local Module = {}

Module.plugin_spec = {
    {
        "mfussenegger/nvim-lint",
    }
}

local linters_by_ft = {
    markdown = {
        "vale",
        "markdownlint",
    },
    python = {
        "ruff",
    },
    go = {
        "golangcilint"
    },
    yaml = {
        "yamllint",
    }
}

Module.activate = function ()
    local lint = require('lint')
    lint.linters_by_ft = linters_by_ft

    vim.api.nvim_create_autocmd({ "BufWritePost" }, {
        callback = function () lint.try_lint() end,
    })


    vim.api.nvim_create_autocmd(
        {
            "BufEnter",
            "BufWritePost",
        },
        {
            callback = function ()
                lint.try_lint({"cspell"})
            end
        }
    )
end

return Module

