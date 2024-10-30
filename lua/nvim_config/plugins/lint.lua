local linters_by_file_type = {
    markdown = {
        "vale",
        "markdownlint",
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
            local cspell_from_stdin_config = require("nvim_config.linters.cspell_from_stdin")

            if vim.fn.executable(cspell_from_stdin_config.cmd) == 1 then
                lint.linters.cspell_from_stdin = cspell_from_stdin_config
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
            else
                vim.notify("Failed to find `" .. cspell_from_stdin_config.cmd .. "`", vim.log.levels.ERROR)
            end

            vim.api.nvim_create_autocmd({ "BufWritePost" }, {
                callback = function() lint.try_lint() end,
            })
        end,
    },
}
