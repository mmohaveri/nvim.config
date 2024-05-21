local signs = {
    {
        name = "DiagnosticSignError",
        text = "",
    },
    {
        name = "DiagnosticSignWarn",
        text = "",
    },
    {
        name = "DiagnosticSignHint",
        text = "",
    },
    {
        name = "DiagnosticSignInfo",
        text = "",
    },
}

local function starts_with(inp, prefix) return string.sub(inp, 1, string.len(prefix)) == prefix end

local function is_diagnostics_disabled(bufnr)
    if bufnr == nil then return true end

    local buf_infos = vim.fn.getbufinfo(bufnr)
    if #buf_infos == 0 then return true end

    local buf_info = buf_infos[1]

    if buf_info.name == nil or buf_info.name == "" or starts_with(buf_info.name, "term://") then return true end
end

local diagnostic_config = {
    virtual_text = function(_, bufnr) return not is_diagnostics_disabled(bufnr) end,
    signs = function(_, bufnr)
        if is_diagnostics_disabled(bufnr) then return false end

        return {
            active = signs,
        }
    end,
    update_in_insert = true,
    underline = function(_, bufnr) return not is_diagnostics_disabled(bufnr) end,
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
    border = "rounded",
}

local handlers = vim.lsp.handlers

local function lsp_setup()
    for _, sign in ipairs(signs) do
        vim.fn.sign_define(sign.name, {
            texthl = sign.name,
            text = sign.text,
            numhl = "",
        })
    end

    vim.diagnostic.config(diagnostic_config)

    handlers["textDocument/hover"] = vim.lsp.with(handlers.hover, handler_config)
    handlers["textDocument/signatureHelp"] = vim.lsp.with(handlers.signature_help, handler_config)
end

return lsp_setup
