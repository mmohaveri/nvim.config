local options = {noremap = true, silent = true}
local keymap = vim.keymap.set

return {
    {
        "nvim-lualine/lualine.nvim",
        config = true,
    },
    {
        "m4xshen/smartcolumn.nvim",
        event = {
            "BufReadPre",
            "BufNewFile",
        },
        opts = {
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
        },
    },
    {
        "famiu/bufdelete.nvim",
        config = function ()
            keymap("n", "<leader>d", ":Bdelete <CR>", options)
        end
    },
    {
        'stevearc/dressing.nvim',
        config = true,
    },
    {
        "rcarriga/nvim-notify",
        opts = {
            render = "wrapped-compact",
            stages = "slide",
            timeout = 5000,
        },
        init = function ()
            vim.notify = require("notify")
        end
    },
    {
        "mrded/nvim-lsp-notify",
        config = true,
        dependencies = {
            "rcarriga/nvim-notify",
        }
    },
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
        config = true,
    }
}

