local cmp_lsp = require("cmp_nvim_lsp")
local notify = require("notify")

local helpers = require("lsp.helpers")

local function register_lsp(lsp_defenition)
    vim.api.nvim_create_autocmd("FileType", {
        pattern = lsp_defenition.filetypes,
        callback = function()
            local client_capabilities = vim.tbl_deep_extend("force", vim.lsp.protocol.make_client_capabilities(), cmp_lsp.default_capabilities())

            local lsp_server_binray = lsp_defenition.config.cmd[1]

            if not helpers.binary_exists(lsp_server_binray) then
                local error_msg = "Failed to start '" ..
                    lsp_defenition.config.name ..
                    "' LSP client. '" ..
                    lsp_server_binray ..
                    "' binary does not exist!"

                notify(error_msg, "error")
                return
            end

            local client = vim.lsp.start(
                vim.tbl_extend(
                    "force",
                    {
                        capabilities = client_capabilities,
                        on_attach = function(client, buffer_number)
                            if client.name == "typescript" then
                                client.server_capabilities.documentFormattingProvider = false
                            end
                            helpers.set_lsp_keymaps(buffer_number)
                            helpers.set_lsp_highlight_document_if_client_supports(client)
                        end,
                        log_level = vim.lsp.protocol.MessageType.Warning,
                        root_dir = vim.fs.dirname(vim.fs.find(lsp_defenition.root_indicators, { upward = true })[1])
                    },
                    lsp_defenition.config
                )
            )

            vim.lsp.buf_attach_client(0, client)

            notify(lsp_defenition.config.name .. " LSP client attached.")
        end
    })
end

return register_lsp

