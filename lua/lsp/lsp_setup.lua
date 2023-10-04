local signs = {
    {
        name = "DiagnosticSignError",
        text = "",
    },
    {
        name = "DiagnosticSignWarn",
        text = ""
    },
    {
        name = "DiagnosticSignHint",
        text = ""
    },
    {
        name = "DiagnosticSignInfo",
        text = ""
    },
}

local diagnostic_config = {
    virtual_text = false,
    signs = {
        active = signs,
    },
    update_in_insert = true,
    underline = true,
    severity_sort = true,
    float = {
        focusable = false,
        style = "minimal",
        border = "rounded",
        source = "always",
        header = "",
        prefix = "",
    },
}

local handler_config = {
    border = "rounded"
}

local handlers = vim.lsp.handlers

local function lsp_setup()
     for _, sign in ipairs(signs) do
        vim.fn.sign_define(
            sign.name,
            {
                texthl = sign.name,
                text = sign.text,
                numhl = ""
            }
        )
    end

    vim.diagnostic.config(diagnostic_config)

    handlers["textDocument/hover"] = vim.lsp.with(handlers.hover, handler_config)
    handlers["textDocument/signatureHelp"] = vim.lsp.with(handlers.signature_help, handler_config)
end

return lsp_setup
