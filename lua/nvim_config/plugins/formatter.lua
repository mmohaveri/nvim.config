return {
    {
        "stevearc/conform.nvim",
        event = { "BufWritePre" },

        cmd = { "ConformInfo", "Format" },
        keys = {
            {
                "<leader>f",
                function() require("conform").format({ async = true }) end,
                mode = "",
                desc = "Format buffer",
            },
        },
        opts = {
            log_level = vim.log.levels.WARN,
            format_on_save = { timeout_ms = 500 },
            formatters_by_ft = {
                bash = { "beautysh" },
                css = {},
                go = { "goimports", "gofmt" },
                javascript = { "biome" },
                javascriptreact = { "biome" },
                typescript = { "biome" },
                typescriptreact = { "biome" },
                json = { "biome", "jq" },
                latex = { "tex-fmt" },
                lua = { "stylua" },
                markdown = { "markdownfmt", "cbfmt" },
                proto = { "buf" },
                python = { "autopep8", "ruff_fix", "ruff_format" },
                rust = { "rustfmt" },
                sql = {},
                sh = { "shfmt" },
                toml = { "taplo" },
                vue = {},
                yaml = { "yamlfmt" },
                zsh = { "beautysh" },
            },
            default_format_opts = {
                lsp_format = "fallback",
            },
            formatters = {
                ["*"] = { "trim_newlines", "trim_whitespace" },
                autopep8 = {
                    inherit = true,
                    command = "uv",
                    prepend_args = {
                        "run",
                        "--with",
                        "autopep8",
                        "autopep8",
                    },
                },
                beautysh = {
                    inherit = true,
                    command = "uv",
                    prepend_args = {
                        "run",
                        "--with",
                        "beautysh",
                        "beautysh",
                    },
                },
                biome = {
                    inherit = true,
                    command = "npm",
                    prepend_args = {
                        "exec",
                        "--silent",
                        "--yes",
                        "--package=@biomejs/biome",
                        "--",
                        "biome",
                    },
                },
                ruff_fix = {
                    inherit = true,
                    command = "uv",
                    prepend_args = {
                        "run",
                        "--with",
                        "ruff",
                        "ruff",
                    },
                },
                ruff_format = {
                    inherit = true,
                    command = "uv",
                    prepend_args = {
                        "run",
                        "--with",
                        "ruff",
                        "ruff",
                    },
                },
            },
        },
        config = function(_, opts)
            require("conform").setup(opts)
            vim.api.nvim_create_user_command(
                "Format",
                function() require("conform").format({ async = true }) end,
                { nargs = "?" }
            )
        end,

        init = function() vim.o.formatexpr = "v:lua.require('conform').formatexpr()" end,
    },
}

