-- ~/.config/nvim/init.lua
-- Neovim Configuration with Better Autocomplete & Clipboard Fix (FIXED)

-- ============================================================================
-- BASIC SETTINGS
-- ============================================================================

-- Leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Basic editor settings
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.mouse = "a"
vim.opt.showmode = false
vim.opt.clipboard = "unnamedplus"
vim.opt.breakindent = true
vim.opt.undofile = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.signcolumn = "yes"
vim.opt.updatetime = 250
vim.opt.timeout = true
vim.opt.timeoutlen = 300
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.cursorline = true
vim.opt.scrolloff = 8
vim.opt.wrap = false

-- Indentation
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.autoindent = true
vim.opt.smartindent = true

-- Better search
vim.opt.hlsearch = true
vim.opt.incsearch = true

-- Better completion experience
vim.opt.completeopt = "menu,menuone,noselect"

-- ============================================================================
-- CLIPBOARD & DELETE FIX
-- ============================================================================
-- Stop "dd" from overwriting clipboard content (send to black hole by default)
vim.keymap.set("n", "dd", '"_dd', { noremap = true })
vim.keymap.set("n", "x", '"_x', { noremap = true })
vim.keymap.set("v", "d", '"_d', { noremap = true })

-- Use leader+d if you *want* to delete into clipboard
vim.keymap.set("n", "<leader>d", "dd", { desc = "Cut line into clipboard" })

-- Simple clipboard integration Cmd+C / Cmd+V (macOS)
vim.keymap.set("i", "<D-v>", "<C-r>+", { desc = "Paste from clipboard" })
vim.keymap.set("n", "<D-v>", '"+p', { desc = "Paste from clipboard" })
vim.keymap.set("v", "<D-v>", '"+p', { desc = "Paste from clipboard" })
vim.keymap.set("v", "<D-c>", '"+y', { desc = "Copy to clipboard" })

-- ============================================================================
-- PLUGIN MANAGER (Lazy.nvim)
-- ============================================================================

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "--branch=stable",
    lazyrepo,
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- ============================================================================
-- PLUGINS
-- ============================================================================

require("lazy").setup({

  -- AYU COLORSCHEME
  {
    "Shatur/neovim-ayu",
    priority = 1000,
    config = function()
      require("ayu").setup({ mirage = false })
      vim.cmd.colorscheme("ayu-dark")
    end,
  },

  -- TREESITTER (Better syntax highlighting & code understanding)
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects", -- Better text objects for functions, classes, etc
    },
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = {
          "lua", "python", "javascript", "typescript", "html", "css",
          "json", "yaml", "markdown", "bash", "vim", "vimdoc", "query",
        },
        auto_install = true,
        highlight = { enable = true },
        indent = { enable = true },
        textobjects = {
          select = {
            enable = true,
            lookahead = true,
            keymaps = {
              ["af"] = "@function.outer",
              ["if"] = "@function.inner",
              ["ac"] = "@class.outer",
              ["ic"] = "@class.inner",
            },
          },
        },
      })
    end,
  },

  -- FILE EXPLORER
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("nvim-tree").setup({
        view = { width = 35 },
        renderer = { group_empty = true },
        filters = { dotfiles = false },
        git = { enable = true },
      })
    end,
  },

  -- FUZZY FINDER
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.8",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("telescope").setup({
        defaults = { 
          file_ignore_patterns = { "node_modules", ".git/", "*.pyc" },
          layout_config = { width = 0.9, height = 0.9 }
        },
      })
    end,
  },

  -- MASON (Tools/LSP/DAP installer)
  {
    "williamboman/mason.nvim",
    build = ":MasonUpdate",
    config = function()
      require("mason").setup({ ui = { border = "rounded" } })
    end,
  },

  -- Mason LSP Bridge (FIXED)
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim" },
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = {
          "pyright",       -- Python
          "ts_ls",         -- TypeScript/JavaScript (FIXED)
          "lua_ls",        -- Lua
          "html",          -- HTML
          "cssls",         -- CSS
          "jsonls",        -- JSON
          "bashls",        -- Bash
          "yamlls",        -- YAML
          "marksman",      -- Markdown
        },
        automatic_installation = true,
      })
    end,
  },

  -- LSP Configuration with Status + Signature (FIXED)
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "hrsh7th/cmp-nvim-lsp",
      "j-hui/fidget.nvim",
      "ray-x/lsp_signature.nvim",
    },
    config = function()
      local lspconfig = require("lspconfig")
      local mason_lspconfig = require("mason-lspconfig")
      local capabilities = require("cmp_nvim_lsp").default_capabilities()
      
      require("fidget").setup({}) -- LSP progress/status

      -- Universal on_attach function
      local on_attach = function(_, bufnr)
        local opts = { buffer = bufnr, silent = true }
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
        vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
        vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
        vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
        vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
        vim.keymap.set("n", "<leader>f", vim.lsp.buf.format, opts) -- Format code
        vim.keymap.set({ "n", "i" }, "<C-k>", vim.lsp.buf.signature_help, opts)
        
        -- Enhanced signature help
        require("lsp_signature").on_attach({
          floating_window = true,
          hint_enable = false,
          hi_parameter = "IncSearch",
          zindex = 60,
        }, bufnr)
      end

      -- FIXED: Backward compatible setup
      if mason_lspconfig.setup_handlers then
        mason_lspconfig.setup_handlers({
          function(server)
            lspconfig[server].setup({
              capabilities = capabilities,
              on_attach = on_attach,
            })
          end,
        })
      else
        -- Fallback for older versions
        local servers = mason_lspconfig.get_installed_servers and mason_lspconfig.get_installed_servers() or {}
        for _, server in ipairs(servers) do
          lspconfig[server].setup({
            capabilities = capabilities,
            on_attach = on_attach,
          })
        end
      end

      -- Better diagnostic display
      vim.diagnostic.config({
        virtual_text = true,
        signs = true,
        underline = true,
        update_in_insert = false,
        severity_sort = true,
        float = { border = "rounded" },
      })
    end,
  },

  -- AUTOCOMPLETION (Enhanced)
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",    -- Command line completion
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
      "rafamadriz/friendly-snippets",
      "onsails/lspkind-nvim",
    },
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")
      local lspkind = require("lspkind")

      require("luasnip.loaders.from_vscode").lazy_load()

      cmp.setup({
        snippet = {
          expand = function(args) luasnip.lsp_expand(args.body) end,
        },
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
        formatting = {
          fields = { "kind", "abbr", "menu" },
          format = lspkind.cmp_format({
            mode = "symbol_text",
            maxwidth = 50,
            ellipsis_char = "…",
            menu = {
              nvim_lsp = "[LSP]",
              buffer = "[Buf]",
              path = "[Path]",
              luasnip = "[Snip]",
              cmdline = "[Cmd]",
            },
          }),
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_locally_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.locally_jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { "i", "s" }),
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "luasnip" },
        }, {
          { name = "buffer" },
          { name = "path" },
        }),
        experimental = { ghost_text = true },
      })

      -- Command line completion
      cmp.setup.cmdline(":", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({ { name = "path" } }, { { name = "cmdline" } })
      })
    end,
  },

  -- INTEGRATED TERMINAL
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    config = function()
      require("toggleterm").setup({
        size = 20,
        open_mapping = [[<c-\>]],
        direction = "horizontal",
        float_opts = { border = "curved" },
      })
    end,
  },

  -- GIT INTEGRATION
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("gitsigns").setup({
        signs = {
          add = { text = "+" },
          change = { text = "~" },
          delete = { text = "_" },
          topdelete = { text = "‾" },
          changedelete = { text = "~" },
        },
      })
    end,
  },

  -- UI & PRODUCTIVITY
  { "nvim-lualine/lualine.nvim", dependencies = { "nvim-tree/nvim-web-devicons" }, config = function() require("lualine").setup({ options = { theme = "ayu_dark" } }) end },
  { "windwp/nvim-autopairs", event = "InsertEnter", config = true },
  { "numToStr/Comment.nvim", opts = {} },
  { "lukas-reineke/indent-blankline.nvim", main = "ibl", opts = {} },
  { "folke/which-key.nvim", event = "VeryLazy", config = function() require("which-key").setup() end },
})

-- ============================================================================
-- ENHANCED KEY MAPPINGS
-- ============================================================================
local keymap = vim.keymap.set

-- File operations
keymap("n", "<leader>e", "<cmd>NvimTreeToggle<CR>", { desc = "File Explorer" })
keymap("n", "<leader>w", "<cmd>w<CR>", { desc = "Save" })
keymap("n", "<leader>q", "<cmd>q<CR>", { desc = "Quit" })
keymap("n", "<leader>Q", "<cmd>qa<CR>", { desc = "Quit All" })

-- Telescope (Enhanced)
keymap("n", "<leader>ff", "<cmd>Telescope find_files<CR>", { desc = "Find files" })
keymap("n", "<leader>fg", "<cmd>Telescope live_grep<CR>", { desc = "Grep" })
keymap("n", "<leader>fb", "<cmd>Telescope buffers<CR>", { desc = "Buffers" })
keymap("n", "<leader>fh", "<cmd>Telescope help_tags<CR>", { desc = "Help" })
keymap("n", "<leader>fo", "<cmd>Telescope oldfiles<CR>", { desc = "Recent files" })

-- Buffer navigation
keymap("n", "<leader>bn", "<cmd>bnext<CR>", { desc = "Next buffer" })
keymap("n", "<leader>bp", "<cmd>bprevious<CR>", { desc = "Previous buffer" })
keymap("n", "<leader>bd", "<cmd>bdelete<CR>", { desc = "Delete buffer" })

-- Window navigation
keymap("n", "<C-h>", "<C-w>h", { desc = "Left window" })
keymap("n", "<C-j>", "<C-w>j", { desc = "Down window" })
keymap("n", "<C-k>", "<C-w>k", { desc = "Up window" })
keymap("n", "<C-l>", "<C-w>l", { desc = "Right window" })

-- Resize windows
keymap("n", "<C-Up>", "<cmd>resize +2<CR>", { desc = "Increase height" })
keymap("n", "<C-Down>", "<cmd>resize -2<CR>", { desc = "Decrease height" })
keymap("n", "<C-Left>", "<cmd>vertical resize -2<CR>", { desc = "Decrease width" })
keymap("n", "<C-Right>", "<cmd>vertical resize +2<CR>", { desc = "Increase width" })

-- Better text editing
keymap("v", "<", "<gv", { desc = "Indent left" })
keymap("v", ">", ">gv", { desc = "Indent right" })
keymap("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move line down" })
keymap("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move line up" })

-- Clear search highlighting
keymap("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "Clear search" })

-- Git (using gitsigns)
keymap("n", "<leader>gp", "<cmd>Gitsigns preview_hunk<CR>", { desc = "Preview hunk" })
keymap("n", "<leader>gr", "<cmd>Gitsigns reset_hunk<CR>", { desc = "Reset hunk" })

-- Mason
keymap("n", "<leader>m", "<cmd>Mason<CR>", { desc = "Mason" })

-- ============================================================================
-- AUTOCOMMANDS
-- ============================================================================

-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight yanked text",
  group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
  callback = function() vim.highlight.on_yank() end,
})

-- Disable auto-comment on new lines
vim.api.nvim_create_autocmd("FileType", {
  desc = "Disable auto-comment new line",
  group = vim.api.nvim_create_augroup("disable-auto-comment", { clear = true }),
  pattern = "*",
  callback = function()
    vim.opt_local.formatoptions = vim.opt_local.formatoptions - "c" - "r" - "o"
  end,
})

-- Close some filetypes with <q>
vim.api.nvim_create_autocmd("FileType", {
  desc = "Close with q",
  group = vim.api.nvim_create_augroup("close_with_q", { clear = true }),
  pattern = { "help", "lspinfo", "man", "notify" },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
  end,
})

print("🚀 Neovim ready with VSCode-like experience (FIXED)!")
