local linters_by_file_type = {
    markdown = {
        "vale",
        "markdownlint",
    },
    python = {
        -- "ruff", -- We're using ruff-lsp instead
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

            lint.linters_by_ft = linters_by_file_type
            lint.linters.cspell_from_stdin = require("nvim_config.linters.cspell_from_stdin")

            vim.api.nvim_create_autocmd({ "BufWritePost" }, {
                callback = function() lint.try_lint() end,
            })

            vim.api.nvim_create_autocmd({
                "BufEnter",
                "BufWritePost",
                "TextChanged",
                "TextChangedI",
            }, {
                callback = function()
                    if vim.bo.readonly or vim.tbl_contains(exclude_filetype, vim.bo.filetype) then return end

                    lint.try_lint({ "cspell_from_stdin" })
                end,
            })
        end,
    },
}
