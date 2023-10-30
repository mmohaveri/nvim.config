local Module = {}

function Module.get_active_client_by_name(bufnr, servername)
    for _, client in pairs(vim.lsp.get_active_clients { bufnr = bufnr }) do
        if client.name == servername then
            return client
        end
    end
end

function Module.validate_bufnr(bufnr)
  vim.validate {
    bufnr = { bufnr, 'n' },
  }

  return bufnr == 0 and vim.api.nvim_get_current_buf() or bufnr
end


return Module
