local exclude_filetype = {
    "NvimTree",
}

return {
    {
        "mfussenegger/nvim-lint",
        event = {
            "BufReadPre",
            "BufNewFile",
        },
        config = function()
            local lint = require("lint")

            lint.linters.cspell = require("nvim_config.linters.cspell")
            lint.linters.eslint = require("nvim_config.linters.eslint")
            lint.linters.markdownlint = require("nvim_config.linters.markdownlint")
            lint.linters.yamllint = require("nvim_config.linters.yamllint")

            lint.linters_by_ft = {
                go = {
                    "golangcilint",
                },
                javascript = {
                    "eslint",
                },
                markdown = {
                    "vale",
                    "markdownlint",
                },
                typescript = {
                    "eslint",
                },
                vue = {
                    "eslint",
                },
                yaml = {
                    "yamllint",
                },
            }

            vim.api.nvim_create_autocmd({
                "BufEnter",
                "BufWritePost",
                "TextChanged",
                "TextChangedI",
            }, {
                callback = function()
                    if vim.bo.readonly or vim.tbl_contains(exclude_filetype, vim.bo.filetype) then return end
                    lint.try_lint({ "cspell" })
                end,
            })

            vim.api.nvim_create_autocmd({ "BufWritePost" }, {
                callback = function() lint.try_lint() end,
            })
        end,
    },
}
