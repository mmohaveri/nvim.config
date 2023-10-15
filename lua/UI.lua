-- WinBar
vim.api.nvim_set_hl(0, 'WinBarTag', {})
vim.api.nvim_set_hl(0, 'WinBarName', {italic=true})
vim.api.nvim_set_hl(0, 'WinBar', {bg="#3b3b3b"})
vim.api.nvim_set_hl(0, 'WinBarNC', {bg=nil})
vim.o.winbar = "%#WinBarTag#%{v:lua.require('utils.winbar').winbar_tag()}%*%{v:lua.require('utils.winbar').winbar_path()}%#WinBarName#%{v:lua.require('utils.winbar').winbar_file()}%*"

-- StatusLine
vim.o.laststatus = 3
-- %#lualine_a_command# COMMAND %#lualine_transitional_lualine_a_command_to_lualine_b_command#%#lualine_b_command#  main %<%#lualine_c_command# UI.lua %#lualine_c_command#%=%#lualine_c_command# utf-8 %#lualine_c_command#  %#lualine_x_filetype_DevIconLua_command# %#lualine_c_command# lua %#lualine_b_command# 77%% %#lualine_transitional_lualine_a_command_to_lualine_b_command#%#lualine_a_command#

