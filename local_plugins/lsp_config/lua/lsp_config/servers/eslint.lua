local Module = {}

local lsp = require("lsp_config.utils.lsp")

Module.filetypes = {
    "javascript",
    "javascriptreact",
    "javascript.jsx",
    "typescript",
    "typescriptreact",
    "typescript.tsx",
    "vue",
    "svelte",
    "astro",
}

Module.root_indicators = {
    ".eslintrc",
    ".eslintrc.js",
    ".eslintrc.cjs",
    ".eslintrc.yaml",
    ".eslintrc.yml",
    ".eslintrc.json",
    "eslint.config.js",
    "package.json",
    ".git",
}

Module.config = {
    name = "eslint-language-server",
    cmd = {
        "vscode-eslint-language-server",
        "--stdio",
    },
    -- Refer to https://github.com/Microsoft/vscode-eslint#settings-options for documentation.
    settings = {
        validate = "on",
        packageManager = nil,
        useESLintClass = false,
        experimental = {
            useFlatConfig = false,
        },
        codeActionOnSave = {
            enable = false,
            mode = "all",
        },
        format = true,
        quiet = false,
        onIgnoredFiles = "off",
        rulesCustomizations = {},
        run = "onType",
        problems = {
            shortenToSingleLine = false,
        },
        -- nodePath configures the directory in which the eslint server should start its node_modules resolution.
        -- This path is relative to the workspace folder (root dir) of the server instance.
        nodePath = "",
        -- use the workspace folder location or the file location (if no workspace folder is open) as the working directory
        workingDirectory = {
            mode = "location",
        },
        codeAction = {
            disableRuleComment = {
                enable = true,
                location = "separateLine",
            },
            showDocumentation = {
                enable = true,
            },
        },
    },
    on_new_config = function(config, new_root_dir)
        -- The "workspaceFolder" is a VSCode concept. It limits how far the
        -- server will traverse the file system when locating the ESLint config
        -- file (e.g., .eslintrc).
        config.settings.workspaceFolder = {
            uri = new_root_dir,
            name = vim.fn.fnamemodify(new_root_dir, ":t"),
        }

        -- Support flat config
        if vim.fn.filereadable(new_root_dir .. "/eslint.config.js") == 1 then
            config.settings.experimental.useFlatConfig = true
        end
    end,
    handlers = {
        ["eslint/openDoc"] = function(_, result)
            if not result then return end
            os.execute(string.format("xdg-open %q", result.url))
            return {}
        end,
        ["eslint/confirmESLintExecution"] = function(_, result)
            if not result then return end
            return 4 -- approved
        end,
        ["eslint/probeFailed"] = function()
            vim.notify("[eslint LSP] ESLint probe failed.", vim.log.levels.WARN)
            return {}
        end,
        ["eslint/noLibrary"] = function()
            vim.notify("[eslint LSP] Unable to find ESLint library.", vim.log.levels.WARN)
            return {}
        end,
    },
    commands = {
        EslintFixAll = {
            function()
                vim.notify("Fixing all eslint problems", vim.log.levels.INFO)
                local bufnr = vim.api.nvim_get_current_buf()
                local eslint_lsp_client = lsp.get_active_client_by_name(0, Module.config.name)
                if eslint_lsp_client == nil then return end

                local params = {
                    command = "eslint.applyAllFixes",
                    arguments = {
                        {
                            uri = vim.uri_from_bufnr(bufnr),
                            version = vim.lsp.util.buf_versions[bufnr],
                        },
                    },
                }

                -- TODO: Handle error
                eslint_lsp_client.request_sync("workspace/executeCommand", params, nil, bufnr)
                vim.notify("All eslint problems fixed.", vim.log.levels.INFO)
            end,
            description = "Fix all eslint problems for this buffer",
        },
    },
    on_attach = function(_, bufnr)
        vim.api.nvim_create_autocmd("BufWritePre", {
            buffer = bufnr,
            command = "EslintFixAll",
        })
    end,
}

Module.description = [[
Provides ESLint as a language server.
Uses `vscode-eslint-language-server` which is a part of
[vscode-langservers-extracted](https://github.com/hrsh7ty/vscode-langservers-extracted) which can
be installed via npm:

```sh
npm i -g vscode-langservers-extracted
```
]]

return Module
