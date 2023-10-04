local cmp_lsp = require("cmp_nvim_lsp")

local function set_lsp_highlight_document_if_client_supports(client)
  if client.server_capabilities.documentHighlight then
    vim.api.nvim_exec(
      [[
      augroup lsp_document_highlight
        autocmd! * <buffer>
        autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
        autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
      augroup END
    ]],
      false
    )
  end
end

local function set_lsp_keymaps(buffer_number)
    local opts = { noremap = true, silent = true }
    vim.api.nvim_buf_set_keymap(buffer_number, "n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
    vim.api.nvim_buf_set_keymap(buffer_number, "n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
    vim.api.nvim_buf_set_keymap(buffer_number, "n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
    vim.api.nvim_buf_set_keymap(buffer_number, "n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
    vim.api.nvim_buf_set_keymap(buffer_number, "n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
    vim.api.nvim_buf_set_keymap(buffer_number, "n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
    vim.api.nvim_buf_set_keymap(buffer_number, "n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
    -- vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
    -- vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>f", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
    vim.api.nvim_buf_set_keymap(buffer_number, "n", "[d", '<cmd>lua vim.diagnostic.goto_prev({ border = "rounded" })<CR>', opts)
    vim.api.nvim_buf_set_keymap(buffer_number, "n", "gl", '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
    vim.api.nvim_buf_set_keymap(buffer_number, "n", "]d", '<cmd>lua vim.diagnostic.goto_next({ border = "rounded" })<CR>', opts)
    vim.api.nvim_buf_set_keymap(buffer_number, "n", "<leader>q", "<cmd>lua vim.diagnostic.setloclist()<CR>", opts)
    vim.cmd [[ command! Format execute 'lua vim.lsp.buf.formatting()' ]]
end

local function register_lsp(lsp_defenition)
    vim.api.nvim_create_autocmd("FileType", {
        pattern = lsp_defenition.pattern,
        callback = function()
            local client = vim.lsp.start_client(
                vim.tbl_extend(
                    "force",
                    {
                        capabilities = cmp_lsp.default_capabilities(),
                        on_attach = function(client, buffer_number)
                            if client.name == "tsserver" then
                                client.server_capabilities.documentFormattingProvider = false
                            end
                            set_lsp_keymaps(buffer_number)
                            set_lsp_highlight_document_if_client_supports(client)
                        end,
                        log_level = vim.lsp.protocol.MessageType.Warning,
                        root_dir = vim.fs.dirname(vim.fs.find(lsp_defenition.root_indicators, { upward = true })[1])
                    },
                    lsp_defenition.config
                )
            )

            vim.lsp.buf_attach_client(0, client)
        end
    })
end

return register_lsp

