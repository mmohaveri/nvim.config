local options = {noremap = true, silent = true}
local keymap = vim.keymap.set

local function ufo_virtual_text_handler (virtText, start_line_no, end_line_number, width, truncate)
    local newVirtText = {}
    local suffix = (' 󰁂 %d '):format(end_line_number - start_line_no)
    local sufWidth = vim.fn.strdisplaywidth(suffix)
    local targetWidth = width - sufWidth
    local curWidth = 0
    for _, chunk in ipairs(virtText) do
        local chunkText = chunk[1]
        local chunkWidth = vim.fn.strdisplaywidth(chunkText)
        if targetWidth > curWidth + chunkWidth then
            table.insert(newVirtText, chunk)
        else
            chunkText = truncate(chunkText, targetWidth - curWidth)
            local hlGroup = chunk[2]
            table.insert(newVirtText, {chunkText, hlGroup})
            chunkWidth = vim.fn.strdisplaywidth(chunkText)
            -- str width returned from truncate() may less than 2nd argument, need padding
            if curWidth + chunkWidth < targetWidth then
                suffix = suffix .. (' '):rep(targetWidth - curWidth - chunkWidth)
            end
            break
        end
        curWidth = curWidth + chunkWidth
    end
    table.insert(newVirtText, {suffix, 'MoreMsg'})
    return newVirtText
end

return {
    {
        "mbbill/undotree",
        event = {
            "BufReadPre",
            "BufNewFile",
        }
    },
    {
        "lewis6991/gitsigns.nvim",
        event = {
            "BufReadPre",
            "BufNewFile",
        },
        opts = {
            signs = {
                add          = { text = '│' },
                change       = { text = '│' },
                delete       = { text = '_' },
                topdelete    = { text = '‾' },
                changedelete = { text = '~' },
                untracked    = { text = '┆' },
            },
            signcolumn = true,  -- Toggle with `:Gitsigns toggle_signs`
            numhl      = true,  -- Toggle with `:Gitsigns toggle_numhl`
            linehl     = false, -- Toggle with `:Gitsigns toggle_linehl`
            word_diff  = false, -- Toggle with `:Gitsigns toggle_word_diff`
            watch_gitdir = {
                follow_files = true
            },
            attach_to_untracked = true,
            current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
            current_line_blame_opts = {
                virt_text = true,
                virt_text_pos = 'right_align',  -- 'eol' | 'overlay' | 'right_align'
                delay = 100,
                ignore_whitespace = false,
                virt_text_priority = 100,
            },
            current_line_blame_formatter = '<author>, <author_time:%Y-%m-%d> - <summary>',
            sign_priority = 6,
            update_debounce = 100,
            status_formatter = nil,  -- Use default
            max_file_length = 40000, -- Disable if file is longer than this (in lines)
            preview_config = {
                -- Options passed to nvim_open_win
                border = 'single',
                style = 'minimal',
                relative = 'cursor',
                row = 0,
                col = 1
            },
            yadm = {
                enable = false
            },
        }
    },
    {
        'akinsho/toggleterm.nvim',
        version = "*",
        opts = {
            size = 20,
            open_mapping = [[<C-\>]],
            hide_numbers = true,
            shade_filetypes = {},
            autochdir = false,
            shade_terminals = true,
            shading_factor = 2,
            start_in_insert = true,
            insert_mappings = true, -- Apply the "open mapping" even in insert mode.
            persist_size = true,
            direction="horizontal",
            close_on_exit=true,
            shell=vim.o.shell,
            auto_scroll = true,
            winbar = {
                enabled = false,
            },
        },
        init = function ()
            function _G.set_terminal_keymaps()
                local opts = {buffer = 0}
                keymap('t', '<esc>', [[<C-\><C-n>]], opts)
                keymap('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
                keymap('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
                keymap('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
                keymap('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
                keymap('t', '<C-w>', [[<C-\><C-n><C-w>k]], opts)
            end

            vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')
        end
    },
    {
        "willothy/flatten.nvim",
        lazy = false,
        priority = 1001,
        opts = function()
          local saved_terminal

          return {
            window = {
              open = "alternate",
            },
            callbacks = {
              should_block = function(argv)
                -- argv contains all the parts of the CLI command, including Neovim's path, commands, options and files.
                -- We would block if we find the `-b` flag. This allows you to use `nvim -b file1`.
                -- we also block if we find the diff-mode option
                return vim.tbl_contains(argv, "-b") or vim.tbl_contains(argv, "-d")
              end,
              pre_open = function()
                local term = require("toggleterm.terminal")
                local termid = term.get_focused_id()
                saved_terminal = term.get(termid)
              end,
              post_open = function(bufnr, winnr, file_type, is_blocking)
                if is_blocking and saved_terminal then
                  -- Hide the terminal while it's blocking
                  saved_terminal:close()
                else
                  -- If it's a normal file, just switch to its window
                  vim.api.nvim_set_current_win(winnr)
                end

                -- If the file is a git commit, create one-shot autocmd to delete its buffer on write
                if file_type == "gitcommit" or file_type == "gitrebase" then
                  vim.api.nvim_create_autocmd("BufWritePost", {
                    buffer = bufnr,
                    once = true,
                    callback = vim.schedule_wrap(function()
                      vim.api.nvim_buf_delete(bufnr, {})
                    end),
                  })
                end
              end,
              block_end = function()
                -- After blocking ends (for a git commit, etc), reopen the terminal
                vim.schedule(function()
                  if saved_terminal then
                    saved_terminal:open()
                    saved_terminal = nil
                  end
                end)
              end,
            },
          }
        end,
    },
    {
        "kevinhwang91/nvim-ufo",
        dependencies = {
            "kevinhwang91/promise-async",
            "nvim-treesitter/nvim-treesitter",
        },
        opts = {
            provider_selector = function(bufnr, filetype, buftype)
                -- It's possible to use LPS as a provider as well if the treesitter folding is not suitable 
                return {'treesitter', 'indent'}
            end,
            fold_virt_text_handler = ufo_virtual_text_handler,
        },
        init = function ()
            vim.o.foldcolumn = '1'
            vim.o.foldlevel = 99
            vim.o.foldlevelstart = 99
            vim.o.foldenable = true

            foldopen = "⮟"
            foldclose = "⮞"

            local function get_fold(lnum)
                if vim.fn.foldlevel(lnum) <= vim.fn.foldlevel(lnum - 1) then return ' ' end
                return vim.fn.foldclosed(lnum) == -1 and foldopen or foldclose
            end

            _G.get_statuscol = function()
                return get_fold(vim.v.lnum) .. " %s%l "
            end
            vim.o.statuscolumn = "%!v:lua.get_statuscol()"

            -- keymap('n', 'zR', require('ufo').openAllFolds)
            -- keymap('n', 'zM', require('ufo').closeAllFolds)
            -- keymap('n', 'zr', require('ufo').openFoldsExceptKinds)
            -- keymap('n', 'zm', require('ufo').closeFoldsWith)
            keymap('n', 'L', function()
                local winid = require('ufo').peekFoldedLinesUnderCursor()
                if not winid then vim.lsp.buf.hover() end
            end)
        end
    }
}

