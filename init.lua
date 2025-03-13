-- =============================--- =============================--
-- Basic Settings
-- =============================--
vim.opt.relativenumber   = true
vim.opt.number           = true
vim.opt.autoindent       = true
vim.opt.tabstop          = 4
vim.opt.shiftwidth       = 4
vim.opt.smarttab         = true
vim.opt.softtabstop      = 4
vim.opt.mouse            = "a"
vim.opt.encoding         = "UTF-8"
vim.opt.clipboard        = "unnamedplus"
vim.opt.completeopt      = { "menu", "menuone", "noselect" }
vim.opt.scrolloff        = 8
vim.opt.sidescrolloff    = 8

-- Set leader key to space
vim.g.mapleader = " "

-- Install Lazy.nvim
--=============================--
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not ((vim.loop and vim.loop.fs_stat and vim.loop.fs_stat(lazypath)) or vim.fn.isdirectory(lazypath) == 1) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable",
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

-- =============================--
-- Plugin Section (Lazy.nvim)
-- =============================--
require("lazy").setup({
    -- File Explorer
    { 
        "nvim-tree/nvim-tree.lua", 
        url = "https://github.com/nvim-tree/nvim-tree.lua.git",
        dependencies = { 
            { 
                "nvim-tree/nvim-web-devicons",
                url = "https://github.com/nvim-tree/nvim-web-devicons.git" 
            } 
        } 
    },
    -- Fuzzy Finder
    { 
        "nvim-telescope/telescope.nvim", 
        url = "https://github.com/nvim-telescope/telescope.nvim.git",
        dependencies = { 
            { 
                "nvim-lua/plenary.nvim",
                url = "https://github.com/nvim-lua/plenary.nvim.git" 
            } 
        } 
    },
    -- Status Line
    { 
        "nvim-lualine/lualine.nvim",
        url = "https://github.com/nvim-lualine/lualine.nvim.git"
    },
    -- Git Integration
    { 
        "tpope/vim-fugitive",
        url = "https://github.com/tpope/vim-fugitive.git"
    },
    { 
        "lewis6991/gitsigns.nvim",
        url = "https://github.com/lewis6991/gitsigns.nvim.git"
    },
    -- LSP & Autocomplete
    { 
        "neovim/nvim-lspconfig",
        url = "https://github.com/neovim/nvim-lspconfig.git"
    },
    { 
        "williamboman/mason.nvim",
        url = "https://github.com/williamboman/mason.nvim.git"
    },
    { 
        "williamboman/mason-lspconfig.nvim",
        url = "https://github.com/williamboman/mason-lspconfig.nvim.git"
    },
    { 
        "hrsh7th/nvim-cmp",
        url = "https://github.com/hrsh7th/nvim-cmp.git",
        dependencies = {
            { 
                "hrsh7th/cmp-nvim-lsp",
                url = "https://github.com/hrsh7th/cmp-nvim-lsp.git" 
            },
            { 
                "hrsh7th/cmp-buffer",
                url = "https://github.com/hrsh7th/cmp-buffer.git" 
            },
            { 
                "hrsh7th/cmp-path",
                url = "https://github.com/hrsh7th/cmp-path.git" 
            },
            { 
                "hrsh7th/cmp-cmdline",
                url = "https://github.com/hrsh7th/cmp-cmdline.git" 
            },
            { 
                "L3MON4D3/LuaSnip",
                url = "https://github.com/L3MON4D3/LuaSnip.git" 
            },
        }
    },
    -- Code Syntax & Highlighting
    { 
        "nvim-treesitter/nvim-treesitter",
        url = "https://github.com/nvim-treesitter/nvim-treesitter.git",
        build = ":TSUpdate"
    },
    -- Auto Pairs & Commenting
    { 
        "windwp/nvim-autopairs",
        url = "https://github.com/windwp/nvim-autopairs.git"
    },
    { 
        "numToStr/Comment.nvim",
        url = "https://github.com/numToStr/Comment.nvim.git"
    },
    -- Colorschemes
    {
        "folke/tokyonight.nvim",
        url = "https://github.com/folke/tokyonight.nvim.git",
        opts = {
            style = "storm",
            transparent = false,
            on_colors = function(colors)
                colors.bg = "#000000" -- Pure black background
                colors.bg_dark = "#000000" -- Ensure dark areas are also black
                colors.fg = "#c0caf5" -- Light purple-ish white text
                colors.comment = "#616c99" -- Softer gray-blue for comments
                colors.green = "#9ece6a" -- Bright green for strings
                colors.red = "#f7768e" -- Vibrant red for errors
                colors.blue = "#7aa2f7" -- Cool blue for keywords
                colors.yellow = "#e0af68" -- Warm yellow for functions
            end,
        },
    },
    { 
        "rose-pine/neovim", 
        url = "https://github.com/rose-pine/neovim.git",
        as = "rose-pine"
    },
    { 
        "ellisonleao/gruvbox.nvim", 
        url = "https://github.com/ellisonleao/gruvbox.nvim.git"
    },
    -- Better Keybindings Display
    { 
        "folke/which-key.nvim",
        url = "https://github.com/folke/which-key.nvim.git"
    },
    -- NeoCodeium: AI completion plugin powered by Codeium
    { 
        "monkoose/neocodeium",
        event = "VeryLazy",
        url = "https://github.com/monkoose/neocodeium.git",
        config = function()
            local neocodeium = require("neocodeium")
            neocodeium.setup()
            vim.keymap.set("i", "<A-f>", neocodeium.accept)
            vim.keymap.set("i", "<A-w>", neocodeium.accept_word)
            vim.keymap.set("i", "<A-a>", neocodeium.accept_line)
            vim.keymap.set("i", "<A-e>", neocodeium.cycle_or_complete)
            vim.keymap.set("i", "<A-r>", function() neocodeium.cycle_or_complete(-1) end)
            vim.keymap.set("i", "<A-c>", neocodeium.clear)
        end,
    },
    -- Optional: Primeagen's Harpoon
    { 
        "ThePrimeagen/harpoon", 
        url = "https://github.com/ThePrimeagen/harpoon.git",
        config = function()
            local mark = require("harpoon.mark")
            local ui = require("harpoon.ui")
            vim.keymap.set("n", "<Leader>a", mark.add_file, { desc = "Add file to Harpoon" })
            vim.keymap.set("n", "<C-e>", ui.toggle_quick_menu, { desc = "Open Harpoon menu" })
            vim.keymap.set("n", "<Leader>1", function() ui.nav_file(1) end, { desc = "Go to Harpoon file 1" })
            vim.keymap.set("n", "<Leader>2", function() ui.nav_file(2) end, { desc = "Go to Harpoon file 2" })
        end,
    },
})

-- =============================--
-- nvim-tree Configuration
-- =============================--
require("nvim-tree").setup({
    view = {
        width = 30,
        side = "left",
        adaptive_size = true,
    },
    renderer = {
        icons = { show = { git = true, folder = true, file = true } },
    },
    update_focused_file = { enable = true, update_root = true },
})
vim.keymap.set("n", "<C-b>", ":NvimTreeToggle<CR>", { silent = true })

-- =============================--
-- Telescope Configuration
-- =============================--
local telescope = require("telescope.builtin")
vim.keymap.set("n", "<C-p>", telescope.find_files, { silent = true })
vim.keymap.set("n", "<Leader>f", telescope.live_grep, { silent = true })
vim.keymap.set("n", "<Leader>c", telescope.colorscheme, { desc = "Switch colorscheme" })

-- =============================--
-- lualine Configuration (Status Bar)
-- =============================--
require("lualine").setup({ options = { theme = "auto" } })

-- =============================--
-- Git Signs Configuration
-- =============================--
require("gitsigns").setup()

-- =============================--
-- LSP Configuration (Mason + LSP)
-- =============================--
require("mason").setup()
require("mason-lspconfig").setup({
    ensure_installed = { "ts_ls", "html", "cssls", "jsonls", "lua_ls" },
    automatic_installation = true,
})
require("lspconfig").ts_ls.setup({
    filetypes = { "javascript", "javascriptreact" },
})
require("lspconfig").html.setup({})
require("lspconfig").cssls.setup({})
require("lspconfig").jsonls.setup({})
require("lspconfig").lua_ls.setup({
    settings = {
        Lua = {
            runtime = { version = 'LuaJIT' },
            diagnostics = { globals = { 'vim' } },
            workspace = { library = vim.api.nvim_get_runtime_file("", true) },
            telemetry = { enable = false },
        },
    },
})

-- =============================--
-- nvim-cmp Configuration (Autocomplete)
-- =============================--
local cmp = require("cmp")
cmp.setup({
    snippet = {
        expand = function(args)
            require("luasnip").lsp_expand(args.body)
        end,
    },
    mapping = cmp.mapping.preset.insert({
        ["<Tab>"] = function(fallback)
            local neocodeium = require("neocodeium")
            if neocodeium.visible() then
                neocodeium.accept()
            else
                fallback()
            end
        end,
        ["<CR>"]  = cmp.mapping.confirm({ select = true }),
    }),
    sources = cmp.config.sources({
        { name = "nvim_lsp" },
        { name = "buffer" },
        { name = "path" },
    }),
})
vim.opt.clipboard = "unnamedplus"

-- =============================--
-- Auto Pairs Setup
-- =============================--
require("nvim-autopairs").setup{}
local cmp_autopairs = require("nvim-autopairs.completion.cmp")
cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())

-- =============================--
-- Treesitter Configuration
-- =============================--
require("nvim-treesitter.configs").setup({
    ensure_installed = { "lua", "javascript", "typescript", "html", "css", "json" },
    highlight = { enable = true },
    indent = { enable = true },
})

-- =============================--
-- Colorscheme (Default to tokyonight-storm with black background)
-- =============================--
vim.cmd("colorscheme tokyonight-storm")

-- =============================--
-- Key Mappings & Useful Bindings
-- =============================--
vim.keymap.set("n", "<C-s>", ":w<CR>", { silent = true })        -- Save file
vim.keymap.set("n", "<C-n>", ":enew<CR>", { silent = true })    -- New file
vim.keymap.set("n", "<C-q>", ":q<CR>", { silent = true })       -- Quit
vim.keymap.set("n", "<C-z>", "u", { silent = true })            -- Undo
vim.keymap.set("n", "<C-S-z>", "<C-r>", { silent = true })      -- Redo
vim.keymap.set("v", "<C-c>", '"+y', { silent = true })          -- Copy (Visual mode)
vim.keymap.set("v", "<C-x>", '"+d', { silent = true })          -- Cut (Visual mode)
vim.keymap.set("i", "<C-v>", '<C-r>+', { silent = true })       -- Paste (Insert mode)
vim.keymap.set("n", "<C-v>", '"+p', { silent = true })          -- Paste (Normal mode)
vim.keymap.set("n", "<C-Tab>", ":bnext<CR>", { silent = true }) -- Next buffer
vim.keymap.set("n", "<C-S-Tab>", ":bprevious<CR>", { silent = true }) -- Previous buffer
vim.keymap.set("n", "<C-a>", "ggVG", { silent = true })         -- Select All{ silent = true })         -- Select All
