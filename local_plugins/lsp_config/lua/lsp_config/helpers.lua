local Module = {}

function Module.set_lsp_highlight_document_if_client_supports(client)
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

---@param input string
local function _remove_dash_prefix(input) return input.gsub(input, "^%-+", "") end

---@param command_definition table<string|integer, any>
local function _get_command_options(command_definition)
    ---@type table<string, any>
    local command_options = {}

    for option_name, option_value in pairs(command_definition) do
        if type(option_name) == "string" then
            option_name = _remove_dash_prefix(option_name)
            if option_name == "description" then option_name = "desc" end

            command_options[option_name] = option_value
        end
        -- TODO: We're ignoring cases where command arguments are getting passed as positional strings
    end
    return command_options
end

---@param user_commands table<string, table<string|integer, any>> | nil
function Module.register_user_commands(user_commands)
    if user_commands == nil then return end

    for command_name, command_definition in pairs(user_commands) do
        local command_function = command_definition[1]
        local command_options = _get_command_options(command_definition)
        vim.api.nvim_create_user_command(
            command_name,
            function(info) command_function(unpack(info.fargs)) end,
            command_options
        )

        vim.notify("'" .. command_name .. "' command registered.", vim.log.levels.INFO)
    end
end

return Module
