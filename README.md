# Neovim configuration

This repository contains my neovim configuration.

## Installation

First of all, install neovim by downloading its latest version from [its repository](https://github.com/neovim/neovim/releases).
You can put in in `/usr/local` or `~/.local`, just don't forget to add its bin
directory to your `PATH`.

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

As newer versions of neovim make it easy to instantiate language servers without
any additional plugins, we're not using any language server helper or package manager
(like `lspconfig` and `mason`). This way we'll have to install and configure language
servers manually, but it will gives us more granular control over them.

### All files

This configuration uses cspell to spell check. You can install it using npm:

```bash
npm install -g cspell
```

### Lua

For LSP, install the latest version of [lua-language-server](https://github.com/LuaLS/lua-language-server).
Keep in mind that `lua-language-server` uses its `log` path to store log and cache
data, so your language server users will need to have write access to it. The
easiest way it to allow read & execute permissions for all users to this directory.

For formatting, install [StyLua](https://github.com/JohnnyMorganz/StyLua) from
cargo:

```bash
`cargo install stylua`.
```

### Python

For LSP, install `pyright` and `ruff-lsp` in the python environment that you want,
just keep in mind that you need to start the nvim process while the virtual environment
is active.

For lint, install `ruff`. However, using ruff along side ruff-lsp will cause error
duplication, so we'll disable it in linter configuration.

For formatting, install `ruff` and `autopep8`. They both can be installed using pip:

```bash
pipx install ruff autopep8
```

### Javascript & Typescript

For LSP, install `typescript` and `typescript-language-server` from npm:

```bash
npm install -g typescript typescript-language-server
```

For formatting, install [Biome](https://github.com/biomejs/biome):

```bash
`npm install -g --save-exact @biomejs/biome`
```

### YAML

For LSP install [`yaml-language-server`](https://github.com/redhat-developer/yaml-language-server)
from npm:

```bash
npm install -g yaml-language-server
```

For lint, install [`yamllint`](https://github.com/adrienverge/yamllint) from pip:

```bash
pipx install yamllint
```

For formatting install [yamlfmt](https://github.com/google/yamlfmt):

```bash
go install github.com/google/yamlfmt/cmd/yamlfmt@latest
```

### HTML, CSS, JSON, and ESlint

Install [`vscode-langservers-extracted`](https://github.com/hrsh7th/vscode-langservers-extracted)
from npm:

```bash
npm install -g vscode-langservers-extracted
```

It will provide following language servers:

- vscode-html-language-server
- vscode-css-language-server
- vscode-json-language-server
- vscode-eslint-language-server

For formatting JSON, install [Biome](https://github.com/biomejs/biome) and
[jq](https://github.com/jqlang/jq). Biome can be installed from npm, but jq should
be installed manually:

```bash
`npm install -g --save-exact @biomejs/biome`
```

For formatting CSS & HTML, we should wait for Biome support.

### TOML

Install [taplo](https://github.com/tamasfe/taplo). As the npm build does not have
lsp feature enabled, so you'll need to either download the full
binary release, or install it using cargo (with lsp feature):

```bash
cargo install taplo-cli --locked --features lsp
```

### markdown

For lint, install [`markdownlint-cli`](https://github.com/igorshubovych/markdownlint-cli)
from npm. Also install [vale](https://vale.sh/) for better lints.

```bash
npm install -g markdownlint-cli
```

### LaTeX

Install texlab in full from your distribution. It comes with texlab for LSP,
latexmk for build, and latexindend for linting and formatting.

### Go

For LSP, you'll need gopls which is a part of standard go distribution.
For linting, install golangcilint. For formatting you'll need gofmt and goimports
which are a part of standard go distribution.

### Rust

For LSP, you'll need rust-analyzer and for formatting you'll need rustfmt.
Both are part of standard rust installation.

### ZSH

For formatting install [beutysh](https://github.com/lovesegfault/beautysh):

```bash
pip install beautysh
```

### Bash

For parsing & formatting install [shfmt](https://github.com/mvdan/sh):

```bash
go install mvdan.cc/sh/v3/cmd/shfmt@latest
```

## Choice justification

### Bufferline plugins are missing

This config does not use any bufferline plugin to show open buffers in a manner
similar to tabs in other IDEs. That's because the idea of tabs in other IDEs do
not transfer well to open buffers in vim. You can't re-order open buffers and
navigating between open buffers using :bnext and :bprevious is not trivial (due
to order of the buffers).

A better way to navigate in vim is to use native GoToDefinition, FindUsage, and
other navigation tools like NvimTree, Telescope, and Harpoon.

### A custom WinBar is being used

Normal WinBar plugins either provide too much, or too little. I just need a WinBar
that shows the file (and its path) in a readable way while showing the state of
the buffer. That's why this configuration has its own WinBar (which is heavily influenced
by WinBar.nvim plugin).

## Wishlist

### Things to look into in future

- [nvim-dap](https://github.com/mfussenegger/nvim-dap): a Debug Adapter Protocol
  client implementation for Neovim
  - [telescope-dap.nvim](https://github.com/nvim-telescope/telescope-dap.nvim)
- Read [lsp-toggle.nvim](https://github.com/adoyle-h/lsp-toggle.nvim) and
  integrate it into our flow (it's using lspconfig, we're not)
- Figure out a better diff mechanism in undotree [delta](https://github.com/dandavison/delta)
- Store longterm undotree history.
- Register management using Telescope UI


### Misc

- Inlay Hint
- Wrap text for text files (like markdown)
- A buffer switcher/manager plugin
  - harpoon
  - [JABS.nvim](https://github.com/matbme/JABS.nvim)
  - [buffer_manager.nvim](https://github.com/j-morano/buffer_manager.nvim)
- [rest.nvim](https://github.com/rest-nvim/rest.nvim) plugin to test REST APIs easier.
- Close extra buffers, maybe of the following plugins
  - [close-buffers.nvim](https://github.com/kazhala/close-buffers.nvim)
  - [nvim-early0retirement](https://github.com/chrisgrieser/nvim-early-retirement)
- Better color column, maybe of the following plugins
  - [virt-column.nvim](https://github.com/lukas-reineke/virt-column.nvim)
  - [virtcolumn.nvim](https://github.com/xiyaowong/virtcolumn.nvim)
- Noice
