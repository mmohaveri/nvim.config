local Module = {}

local winbar_config = {
    enabled = true,

    show_file_path = true,
    show_symbols = true,

    colors = {
        path = '', -- You can customize colors like #c946fd
        file_name = '',
        symbols = '',
    },

    icons = {
        file_icon_default = '',
        seperator = '>',
        editor_state = '●',
        lock_icon = '',
    },

    exclude_filetype = {
        'help',
        'startify',
        'dashboard',
        'packer',
        'neogitstatus',
        'NvimTree',
        'Trouble',
        'alpha',
        'lir',
        'Outline',
        'spectre_panel',
        'toggleterm',
        'qf',
    }
}

local smartcolumn_config = {
    colorcolumn = {
        "100",
        "120",
        "130",
    },
    disabled_filetypes = {
        "help",
        "text",
        "markdown",
        "NvimTree",
        "lazy",
        "mason",
    },
    scope = "window",
}

Module.plugin_spec = {
    {
        "akinsho/bufferline.nvim",
        dependencies = {
            'nvim-tree/nvim-web-devicons',
        },
    },
    {
        "fgheng/winbar.nvim",
        config = winbar_config,
    },
    {
        "nvim-lualine/lualine.nvim",
        opts = {},
    },
    {
        "m4xshen/smartcolumn.nvim",
        config = smartcolumn_config,
    },
    {
        "famiu/bufdelete.nvim",
    },
}

Module.activate = function()
    local bufferline = require('bufferline')
    local config = {
        options = {
            mode = "buffers",
            style_preset = bufferline.style_preset.minimal, -- or default
            themable = true,                                -- Allows highlight groups to be overriden i.e. sets highlights as default
            numbers = "buffer_id",
            close_command = "Bdelete %d",                   -- Close buffer on click on close icon 
            right_mouse_command = false,                    -- Command to run when right click on tab
            left_mouse_command = "buffer %d",               -- Move to buffer when left click on tab 
            middle_mouse_command = "Bdelete %d",            -- Close buffer when middle click on tab
            indicator = {
                style = 'underline',                        -- Mark the active buffer with an underline
            },
            buffer_close_icon = '󰅖',
            modified_icon = '●',
            close_icon = '',
            left_trunc_marker = '',
            right_trunc_marker = '',

            max_name_length = 18,
            max_prefix_length = 15,                         -- prefix used when a buffer is de-duplicated
            truncate_names = true,                          -- whether or not tab names should be truncated
            tab_size = 18,
            diagnostics = "nvim_lsp",
            diagnostics_update_in_insert = false,
            offsets = {
                {
                    filetype = "NvimTree",
                    text = "File Explorer",
                    text_align = "left",
                    separator = true,
                }
            },
            color_icons = true,
            get_element_icon = function(element)
              -- element consists of {filetype: string, path: string, extension: string, directory: string}
              -- This can be used to change how bufferline fetches the icon
              -- for an element e.g. a buffer or a tab.
              -- e.g.
              local icon, hl = require('nvim-web-devicons').get_icon_by_filetype(element.filetype, { default = false })
              return icon, hl
            end,
            show_buffer_icons = true,
            show_buffer_close_icons = true,
            show_close_icon = true,
            show_tab_indicators = true,
            show_duplicate_prefix = true, -- whether to show duplicate buffer prefix
            persist_buffer_sort = true, -- whether or not custom sorted buffers should persist
            move_wraps_at_ends = false, -- whether or not the move command "wraps" at the first or last position
            -- can also be a table containing 2 custom separators
            -- [focused and unfocused]. eg: { '|', '|' }
            separator_style = "thin",
            enforce_regular_tabs = false,  -- ?
            always_show_bufferline = true,
            hover = {
                enabled = true,
                delay = 200,
                reveal = {'close'}
            },
            sort_by = 'insert_after_current',
        }
    }

    bufferline.setup(config)
end

return Module
