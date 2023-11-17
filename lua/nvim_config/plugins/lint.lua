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
    },
    typescript = {
        "eslint"
    },
    javascript = {
        "eslint"
    },
    vue = {
        "eslint"
    }
}

return {
    {
        "mfussenegger/nvim-lint",
        event = {
            "BufReadPre",
            "BufNewFile",
        },
        config = function ()
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
    }
}

