return {
    {
        "mhartington/formatter.nvim",
        opts = function()
            return {
                logging = true,
                log_level = vim.log.levels.WARN,
                -- Formatter configurations for each "filetyle"
                -- They'll be executed in order
                filetype = {
                    ["*"] = {
                        require("formatter.filetypes.any").remove_trailing_whitespace,
                    },

                    css = {},

                    go = {
                        require("formatter.filetypes.go").goimports,
                        require("formatter.filetypes.go").gofmt,
                    },
                    javascript = {
                        -- Requires [Biome](https://github.com/biomejs/biome): `npm install -g --save-exact @biomejs/biome`
                        require("formatter.filetypes.javascript").biome,
                    },
                    javascriptreact = {
                        require("formatter.filetypes.javascriptreact").biome,
                    },
                    typescript = {
                        require("formatter.filetypes.typescript").biome,
                    },
                    typescriptreact = {
                        require("formatter.filetypes.typescriptreact").biome,
                    },
                    json = {
                        require("formatter.filetypes.json").biome,
                        -- Requires [jq](https://github.com/jqlang/jq)
                        require("formatter.filetypes.json").jq,
                    },
                    latex = {
                        require("formatter.filetypes.latex").latexindent,
                    },
                    lua = {
                        -- Requires [StyLua](https://github.com/JohnnyMorganz/StyLua): `cargo install stylua`
                        require("formatter.filetypes.lua").stylua,
                    },
                    markdown = {},
                    proto = {
                        -- Requires [Buf](https://github.com/bufbuild/buf): `npm install -g @bufbuild/buf`
                        require("formatter.filetypes.proto").buf_format,
                    },
                    python = {
                        -- Requires [autopep8](): `pip install autopep8`
                        require("formatter.filetypes.python").autopep8,
                        -- Requires [ruff](): `pip install ruff`
                        require("formatter.filetypes.python").ruff,
                        {
                            exe = "ruff",
                            args = { "--fix", "-q", "-" },
                            stdin = true,
                        },
                    },
                    rust = {
                        require("formatter.filetypes.rust").rustfmt,
                    },
                    sql = {},
                    sh = {
                        require("formatter.filetypes.sh").shfmt,
                    },
                    toml = {
                        -- Requires [taplo](https://github.com/tamasfe/taplo): `cargo install taplo-cli --locked --features lsp`
                        require("formatter.filetypes.toml").taplo,
                    },
                    vue = {},
                    yaml = {
                        -- Requires [yamlfmt](https://github.com/google/yamlfmt): `go install github.com/google/yamlfmt/cmd/yamlfmt@latest`
                        require("formatter.filetypes.yaml").yamlfmt,
                    },
                    zsh = {
                        -- Requires [beutysh](https://github.com/lovesegfault/beautysh): `pip install beautysh`
                        require("formatter.filetypes.yaml").beutysh,
                    },
                },
            }
        end,
    },
}
