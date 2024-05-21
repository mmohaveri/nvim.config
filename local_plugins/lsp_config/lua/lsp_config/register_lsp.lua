local cmp_lsp = require("cmp_nvim_lsp")

local helpers = require("lsp_config.helpers")
local path = require("lsp_config.utils.path")

local function register_lsp(lsp_definition)
    vim.api.nvim_create_autocmd("FileType", {
        pattern = lsp_definition.filetypes,
        callback = function()
            if lsp_definition.should_skip ~= nil and lsp_definition.should_skip() then return end

            local client_capabilities = vim.tbl_deep_extend(
                "force",
                vim.lsp.protocol.make_client_capabilities(),
                cmp_lsp.default_capabilities(),
                {
                    textDocument = {
                        foldingRange = {
                            dynamicRegistration = false,
                            lineFoldingOnly = true,
                        },
                    },
                }
            )

            local lsp_server_binary = lsp_definition.config.cmd[1]

            if not path.binary_exists(lsp_server_binary) then
                local error_msg = "Failed to start '"
                    .. lsp_definition.config.name
                    .. "' LSP client. '"
                    .. lsp_server_binary
                    .. "' binary does not exist!"

                vim.notify(error_msg, vim.log.levels.ERROR)
                return
            end

            local client = vim.lsp.start(vim.tbl_extend("force", {
                capabilities = client_capabilities,
                on_attach = function(client, buffer_number)
                    if client.name == "typescript" then
                        client.server_capabilities.documentFormattingProvider = false
                    end
                    helpers.set_lsp_keymaps(buffer_number)
                    helpers.set_lsp_highlight_document_if_client_supports(client)
                end,
                log_level = vim.lsp.protocol.MessageType.Warning,
                root_dir = vim.fs.dirname(vim.fs.find(lsp_definition.root_indicators, { upward = true })[1]),
            }, lsp_definition.config))

            helpers.register_user_commands(lsp_definition.config.commands)
            vim.lsp.buf_attach_client(0, client)

            vim.notify("'" .. lsp_definition.config.name .. "' LSP client attached.", vim.log.levels.INFO)
        end,
    })
end

return register_lsp
