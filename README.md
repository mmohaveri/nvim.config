# Neovim configuration

This repository contains my neovim configuration.

## Installation

First of all, install neovim by downloading its latest version from [its repository](https://github.com/neovim/neovim/releases).
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
    - `lualine.nvim`
    - `smartcolumn.nvim`
    - `bufdelete.nvim`
    - `nvim-notify`
    - `nvim-lsp-notify`
    - `undotree`
    - `gitsigns.nvim`
- For code completion:
    - `nvim-cmp`
    - `cmp-buffer`
    - `cmp-path`
    - `cmp-cmdline`
    - `cmp-nvim-lsp`
    - `cmp-nvim-lua`
    - `LuaSnip`
    - `nvim-ts-autotag`
    - `comment.nvim`
    - `nvim-ts-context-commentstring`
- Linting & formatting
    - `nvim-lit`

It's recommended to install `ripgrep` and `fd` for a better telescope experience.

## Install LSPs, linters and formatters

As newer versions of neovim make it easy to instanciate language servers without any additional plugins,
we're not using any language server helper or package manager (like `lspconfig` and `mason`). This way we'll
have to install and configure language servers manually, but it will gives us more granular control over them.

### All files

This configuration uses cspell to spell check. You can install it using npm:

```bash
npm install -g cspell
```

### Lua

Install the latest version of [lua-language-server](https://github.com/LuaLS/lua-language-server).
Keep in mind that `lua-language-server` uses its `log` path to store log and cache data, so your
language server users will need to have write access to it. The easiest way it to allow read &
execute permissions for all users to this directory.

### Python

For LSP, install `pyright` and `ruff-lsp` in the python environment that you want, just keep in mind that
you need to start the nvim process while the virtual environment is active.

For lint, install `ruff`.

### Javascript & Typescript

Install `typescript` and `typescript-language-server` from npm:


```bash
npm install -g typescript typescript-language-server
```

### YAML

For LSP install [`yaml-language-server`](https://github.com/redhat-developer/yaml-language-server) from npm:


```bash
npm install -g yaml-language-server
```

For lint, install [`yamllint`]() from pip:

```bash
pipx install yamllint
```

### HTML, CSS, JSON, and ESlint

Install [`vscode-langservers-extracted`](https://github.com/hrsh7th/vscode-langservers-extracted) from npm:

```bash
npm install -g vscode-langservers-extracted
```

It will provide following language servers:

- vscode-html-language-server
- vscode-css-language-server
- vscode-json-language-server
- vscode-eslint-language-server

### TOML

Install [taplo](https://github.com/tamasfe/taplo). As the npm build does not have
lsp feature enabled, so you'll need to either download the full
binary release, or install it using cargo (with lsp feature):  

```bash
cargo install taplo-cli --locked --features lsp
```

### markdown

For lint, install [`markdownlint-cli`]() from npm. Also install [vale]() for better lints.

```bash
npm install -g markdownlint-cli
```

### LaTeX

Install [LTeX Language Server](https://github.com/valentjn/ltex-ls) for lsp. Simply download 
the latest release from the repository and put it in `/usr/local/`, finally add the path of
the `bin` directory to your `PATH`.

## Choice justification

### Bufferline plugins are missing

This config does not use any bufferline plugin to show open buffers in a manner similar to tabs in other IDEs.
That's because the idea of tabs in other IDEs do not transfer well to open buffers in vim. You can't re-order
open buffers and navigating between open buffers using :bnext and :bprevious is not trivial (due to order of the buffers).

A better way to navigate in vim is to use native GoToDefinition, FindUsage, and other navigation tools like NvimTree, Telescope, and Harpoon.


### A custom WinBar is being used

Normal WinBar plugins either provide too much, or too little. I just need a WinBar that shows the file (and its path) in a readable way while
showing the state of the buffer. That's why this configuration has its own WinBar (which is heavily influenced by WinBar.nvim plugin).

## Wishlist

- Inlay Hint
- Code formatting
    - Configure auto formatting on save.
    - [Formatter.nvim](https://github.com/mhartington/formatter.nvim) plugin
- Wrap text for text files (like markdown)
- A buffer switcher/manager plugin
    - harpoon
    - [JABS.nvim](https://github.com/matbme/JABS.nvim)
    - [buffer_manager.nvim](https://github.com/j-morano/buffer_manager.nvim)
- [rest.nvim](https://github.com/rest-nvim/rest.nvim) plugin to test REST APIs easier.
- Code folding
    - [nvim-origami](https://github.com/chrisgrieser/nvim-origami)
- Close extra buffers, maybe of the following plugins
    - [close-buffers.nvim](https://github.com/kazhala/close-buffers.nvim)
    - [nvim-early0retirement](https://github.com/chrisgrieser/nvim-early-retirement)
- Better color column, maybe of the following plugins
    - [virt-column.nvim](https://github.com/lukas-reineke/virt-column.nvim)
    - [virtcolumn.nvim](https://github.com/xiyaowong/virtcolumn.nvim)
- A terminal emulator
    - [ToggleTerm]()
- Noice
