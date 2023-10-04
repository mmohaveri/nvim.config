# Neovim configuration

This repository contains my neovim configuration.

## Installation

First of all, install neovim by downloading its latest vrsion from [its repository](https://github.com/neovim/neovim/releases).
You can put in in `/usr/local` or `~/.local`, just don't forget to add its bin directory to your `PATH`.

## Configuration and plugins

Clone this repository into your `~/.config/nvim`:
```bash
git clone git@github.com:mmohaveri/nvim.config.git ~/.config/nvim
```

It will automatically install all required plugins as soon as you open neovim.

### Installed plugins

Currently this configuration uses the following plugins:

- For theme: `vscode.nvim`
- For syntax highlighting: `nvim-treesitter`
- For file explorer and related operations:
    - `nvim-tree`
    - `telescope`
    - `nvim-lsp-file-operations`
- For editors look and ease of use:
    - `bufferline.nvim`
    - `winbar.nvim`
    - `lualine.nvim`
    - `smartcolumn.nvim`
    - `bufdelete.nvim`
- For code completion:
    - `nvim-cmp`
    - `cmp-buffer`
    - `cmp-path`
    - `cmp-cmdline`
    - `cmp-nvim-lsp`
    - `cmp-nvim-lua`
    - `LuaSnip`
    - `nvim-ts-autotag`

It's recommended to install `ripgrep` and `fd` for a better telescope experience.
## Intall LSPs

As newer versions of neovim make it easy to instanciate language servers without any additional plugins,
we're not using any language server helper or package manager (like `lspconfig` and `mason`). This way we'll
have to install and configure language servers manually, but it will gives us more granular controll over them.

### Lua

Install the latest version of [lua-language-server](https://github.com/LuaLS/lua-language-server).
Keep in mind that `lua-language-server` uses its `log` path to store log and cache data, so your
language server users will need to have write access to it. The easiest way it to allow read &
execute permissions for all users to this directory.

## Wishlist

### Plugins

- undo-tree
- harpoon
- glow.nvim

### Configuration
Configure auto formatting on save.
