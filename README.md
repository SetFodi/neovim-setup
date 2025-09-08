# ✨ Modern Neovim Configuration

<div align="center">

![Neovim](https://img.shields.io/badge/NeoVim-%2357A143.svg?&style=for-the-badge&logo=neovim&logoColor=white)
![Lua](https://img.shields.io/badge/lua-%232C2D72.svg?style=for-the-badge&logo=lua&logoColor=white)
![License](https://img.shields.io/badge/license-MIT-blue.svg?style=for-the-badge)

*A clean, modern, and feature-rich Neovim configuration built with Lua*

[Features](#-features) • [Installation](#-installation) • [Keybindings](#-keybindings) • [Plugins](#-plugins)

</div>

---

## 🌟 Features

- **🎨 Beautiful Interface**: AYU Dark colorscheme with modern statusline
- **📁 Smart File Management**: Tree-style file explorer with icons
- **🔍 Powerful Search**: Telescope fuzzy finder for files and content
- **🧠 Intelligent Code**: LSP support with autocompletion and diagnostics
- **⚡ Fast Syntax**: Treesitter-powered syntax highlighting
- **🔧 Tool Management**: Mason for easy LSP server installation
- **📋 Clipboard Integration**: Seamless macOS clipboard support (Cmd+V/Cmd+C)
- **⌨️ Smart Editing**: Auto-pairs, commenting, and indent guides
- **📊 Git Integration**: Visual git signs and status
- **🔑 Discoverable**: Which-key for keybinding hints

## 🚀 Installation

### Prerequisites

- **Neovim 0.10.0+** (required)
- **Git** (for plugin management)
- **Node.js & npm** (for LSP servers)
- **A Nerd Font** (for icons)

### Quick Setup

1. **Backup your existing config** (if any):
```bash
mv ~/.config/nvim ~/.config/nvim.backup
```

2. **Clone this configuration**:
```bash
git clone https://your-repo-url ~/.config/nvim
```

3. **Install Node.js** (for language servers):
```bash
# Using nvm (recommended)
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.5/install.sh | bash
source ~/.zshrc
nvm install --lts

# Or using your package manager
brew install node          # macOS
sudo apt install nodejs npm # Ubuntu
```

4. **Launch Neovim**:
```bash
nvim
```

5. **Install language servers**:
```vim
:Mason
```
Install these servers: `lua-language-server`, `pyright`, `typescript-language-server`, `html-lsp`, `css-lsp`

## ⌨️ Keybindings

### General

| Key | Action | Mode |
|-----|--------|------|
| `<Space>` | Leader key | Normal |
| `<Esc>` | Clear search highlights | Normal |
| `<leader>w` | Save file | Normal |
| `<leader>q` | Quit | Normal |

### File Management

| Key | Action | Mode |
|-----|--------|------|
| `<leader>e` | Toggle file explorer | Normal |
| `<leader>ff` | Find files | Normal |
| `<leader>fg` | Find in files (grep) | Normal |
| `<leader>fb` | Find buffers | Normal |

### Buffer Navigation

| Key | Action | Mode |
|-----|--------|------|
| `<leader>bn` | Next buffer | Normal |
| `<leader>bp` | Previous buffer | Normal |
| `<leader>bd` | Delete buffer | Normal |

### Window Navigation

| Key | Action | Mode |
|-----|--------|------|
| `<C-h>` | Move to left window | Normal |
| `<C-j>` | Move to bottom window | Normal |
| `<C-k>` | Move to top window | Normal |
| `<C-l>` | Move to right window | Normal |

### LSP (Language Server)

| Key | Action | Mode |
|-----|--------|------|
| `gd` | Go to definition | Normal |
| `gr` | Go to references | Normal |
| `K` | Hover documentation | Normal |
| `<leader>ca` | Code actions | Normal |
| `<leader>rn` | Rename symbol | Normal |

### Clipboard (macOS)

| Key | Action | Mode |
|-----|--------|------|
| `<Cmd-v>` | Paste from clipboard | Normal/Insert/Visual |
| `<Cmd-c>` | Copy to clipboard | Visual |

### Tools

| Key | Action | Mode |
|-----|--------|------|
| `<leader>m` | Open Mason | Normal |
| `gcc` | Comment line | Normal |
| `gc` | Comment selection | Visual |

## 🔌 Plugins

### Core Functionality
- **[lazy.nvim](https://github.com/folke/lazy.nvim)** - Plugin manager
- **[nvim-lspconfig](https://github.com/neovim/nvim-lspconfig)** - LSP configuration
- **[mason.nvim](https://github.com/williamboman/mason.nvim)** - LSP server manager
- **[nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter)** - Syntax highlighting

### UI/UX
- **[neovim-ayu](https://github.com/Shatur/neovim-ayu)** - AYU colorscheme
- **[lualine.nvim](https://github.com/nvim-lualine/lualine.nvim)** - Status line
- **[nvim-tree.lua](https://github.com/nvim-tree/nvim-tree.lua)** - File explorer
- **[telescope.nvim](https://github.com/nvim-telescope/telescope.nvim)** - Fuzzy finder
- **[which-key.nvim](https://github.com/folke/which-key.nvim)** - Keybinding hints
- **[indent-blankline.nvim](https://github.com/lukas-reineke/indent-blankline.nvim)** - Indent guides

### Editing
- **[nvim-cmp](https://github.com/hrsh7th/nvim-cmp)** - Autocompletion
- **[LuaSnip](https://github.com/L3MON4D3/LuaSnip)** - Snippet engine
- **[nvim-autopairs](https://github.com/windwp/nvim-autopairs)** - Auto-close brackets
- **[Comment.nvim](https://github.com/numToStr/Comment.nvim)** - Smart commenting

### Git Integration
- **[gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim)** - Git decorations

## 🛠️ Language Support

This configuration provides rich support for:

- **Lua** - Full LSP with Neovim-specific enhancements
- **Python** - Pyright language server
- **TypeScript/JavaScript** - TypeScript language server
- **HTML** - HTML language server with emmet
- **CSS** - CSS language server with validation
- **JSON, YAML, Markdown** - Treesitter syntax highlighting
- **Bash/Shell** - Treesitter syntax highlighting

## 📁 Configuration Structure

```
~/.config/nvim/
└── init.lua          # Main configuration file
```

All configuration is contained in a single, well-organized `init.lua` file with clear sections:

- **Basic Settings** - Editor behavior and options
- **Clipboard Integration** - macOS-specific keybindings
- **Plugin Management** - Lazy.nvim setup
- **Plugin Configurations** - Individual plugin settings
- **Key Mappings** - Custom keybindings
- **Auto Commands** - Event-driven automation

## 🔧 Customization

### Changing the Colorscheme

Edit the colorscheme section in `init.lua`:

```lua
{
  "Shatur/neovim-ayu",
  priority = 1000,
  config = function()
    require("ayu").setup({
      mirage = true,  -- Try mirage variant
    })
    vim.cmd.colorscheme("ayu-mirage")  -- or "ayu-light"
  end,
},
```

### Adding New Language Servers

1. **Install via Mason**:
```vim
:Mason
```

2. **Add to LSP configuration**:
```lua
lspconfig.your_server.setup({ capabilities = capabilities })
```

### Modifying Keybindings

All keybindings are defined in the "KEY MAPPINGS" section:

```lua
keymap("n", "<your-key>", "<your-command>", { desc = "Your description" })
```

## 🚨 Troubleshooting

### LSP Servers Not Working

1. **Check Neovim version**: `nvim --version` (must be 0.10+)
2. **Install Node.js**: Required for most language servers
3. **Check Mason**: `:Mason` to verify installations
4. **Check health**: `:checkhealth lsp`

### Plugin Issues

1. **Clear plugin cache**:
```bash
rm -rf ~/.local/share/nvim
rm -rf ~/.local/state/nvim
rm -rf ~/.cache/nvim
```

2. **Restart Neovim** and let plugins reinstall

### Clipboard Not Working

- **macOS**: Ensure you're using the Cmd+V/Cmd+C keybindings
- **Linux**: Install `xclip` or `wl-clipboard`
- **WSL**: Follow WSL clipboard setup guides

## 📄 License

This configuration is released under the MIT License. Feel free to use, modify, and distribute as you see fit.

---

<div align="center">

**[⬆ Back to Top](#-modern-neovim-configuration)**

Made with ❤️ for the Neovim community

</div>
