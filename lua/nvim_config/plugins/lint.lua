local exclude_filetype = {
    "NvimTree",
    "DressingInput",
    "undotree",
    "toggleterm",
    "TelescopePrompt",
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

            lint.linters_by_ft = {

                markdown = {
                    "vale",
                    require("nvim_config.linters.markdownlint"),
                },
                go = {
                    "golangcilint",
                },
                yaml = {
                    "yamllint",
                },
                typescript = {
                    "eslint",
                },
                javascript = {
                    "eslint",
                },
                vue = {
                    "eslint",
                },
            }

            lint.linters.cspell = require("nvim_config.linters.cspell")

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
