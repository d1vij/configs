vim.opt.hlsearch = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.mouse = "a"
vim.opt.showmode = true
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.opt.cursorline = true
vim.opt.signcolumn = 'yes'
vim.opt.wrap = false
vim.opt.title = true                       -- set the title of window to the value of the titlestring
vim.opt.titlestring = "%<%F%=%l/%L - nvim" -- what the title of the window will be set to:q:
-- Persist undo
vim.opt.undodir = vim.fn.stdpath("cache") .. "/undo"
vim.opt.undofile = true
-- scroll a bit extra horizontally and vertically when at the end/bottomvim.opt.sidescrolloff = 8
vim.opt.scrolloff = 8

vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.autoindent = true
-- Search configuration
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.gdefault = true
vim.lsp.inlay_hint.enable()

vim.opt.termguicolors = true
-- Set the path where lazy.nvim is installed
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

-- Automatically clone lazy.nvim if it doesn't exist
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    lazypath,
  })
end

-- Prepend lazy.nvim to runtime path
vim.opt.rtp:prepend(lazypath)

-- Load plugins via lazy
require("lazy").setup({
  -- Example plugin
 {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup({
        -- Install parsers for these languages
        ensure_installed = { "lua", "python", "javascript", "c", "cpp", "html", "css" },

        -- Enable syntax highlighting
        highlight = { enable = true },

        -- Enable indentation
        indent = { enable = true },

        -- Optional: enable incremental selection
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = "gnn",
            node_incremental = "grn",
            scope_incremental = "grc",
            node_decremental = "grm",
          },
        },
      })
    end,
  }, {
    "nvim-tree/nvim-tree.lua",
    version = "*",
    dependencies = {
      "nvim-tree/nvim-web-devicons", -- optional icons
    },
    config = function()
      require("nvim-tree").setup()
    end,
  },
    {
    "Mofiqul/vscode.nvim",
    lazy = false,       -- Load immediately (not lazily)
    priority = 1000,     -- High priority so it loads before other theme plugins
    config = function()
      -- Optional settings *before* applying the colorscheme
      -- For example, you can disable italics or override colors:
      -- vim.g.vscode_italic_comment = 1
      -- vim.g.vscode_disable_nvimtree_bg = true
      -- vim.g.vscode_color_overrides = { vscLineNumber = "#FF0000" }

      vim.cmd("colorscheme vscode")
    end,
  }
})
-- Toggle file explorer with Ctrl+n
vim.keymap.set("n", "<C-n>", ":NvimTreeToggle<CR>", { noremap = true, silent = true })

