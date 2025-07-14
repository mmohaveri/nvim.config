return {
    no_wrap = function() vim.opt_local.wrap = false end,

    ---@param text_width number | nil line width, decault to 80
    wrap = function(text_width)
        text_width = text_width or 80
        vim.opt_local.wrap = true
        vim.opt_local.textwidth = text_width or 80
    end,

    ---@param tab_width number | nil tab width, decault to 4
    tab_width = function(tab_width)
        tab_width = tab_width or 4
        vim.opt_local.tabstop = tab_width
        vim.opt_local.shiftwidth = tab_width
    end,
}
