-- Basic Settings
local opt = vim.opt
local g = vim.g

-- Line Numbers
opt.number = true             -- Show absolute line number
opt.relativenumber = true     -- Show relative line numbers

-- Mouse Support
opt.mouse = 'a'               -- Enable mouse support

-- Tab and Indentation
opt.tabstop = 4               -- Number of spaces tabs count for
opt.shiftwidth = 4            -- Number of spaces for each indentation level
opt.expandtab = true          -- Use spaces instead of tabs

-- Search Settings
opt.ignorecase = true         -- Ignore case when searching
opt.smartcase = true          -- Override ignorecase if search contains uppercase
opt.incsearch = true          -- Incremental search that shows matches as you type
opt.hlsearch = false          -- Turn off search highlight by default

-- Leader Key
g.mapleader = ' '             -- Set leader key to space

-- Clipboard
opt.clipboard = 'unnamedplus' -- Use system clipboard

vim.opt.termguicolors = true  -- Enable true color support

-- Enable Syntax Highlighting (optional since Neovim uses Tree-sitter for this)
vim.cmd('syntax on')

-- Improve Scrolling
opt.scrolloff = 8             -- Keep 8 lines above/below when scrolling
opt.sidescrolloff = 8         -- Keep 8 columns left/right when scrolling

-- Plugin Manager Initialization
local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd 'packadd packer.nvim'
    return true
  end
  return false
end
local packer_bootstrap = ensure_packer()

require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'                -- Plugin manager

  -- Core Plugins
  use 'tpope/vim-sensible'                    -- Sensible defaults
  use 'junegunn/fzf'                          -- Fuzzy finder
  use { 'neoclide/coc.nvim', branch = 'release' } -- Intellisense engine

  -- Add the Tokyo Night theme
  use 'folke/tokyonight.nvim'                  -- Tokyo Night theme

  -- Quality of Life Plugins
  use 'nvim-lualine/lualine.nvim'             -- Status line
  use 'kyazdani42/nvim-tree.lua'              -- File tree
  use 'lewis6991/gitsigns.nvim'               -- Git integration

  -- Syntax Highlighting and Treesitter
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
    config = function()
      require('nvim-treesitter.configs').setup {
        ensure_installed = { "lua", "python", "javascript", "html", "css" }, -- List of languages to install
        highlight = { enable = true }, -- Enable syntax highlighting
      }
    end
  }

  -- Automatically set up configuration after cloning packer.nvim
  if packer_bootstrap then
    require('packer').sync()
  end
end)

-- Tokyo Night Theme Configuration
require('tokyonight').setup({
  style = "night",  -- Options: "storm", "night", "day"
  transparent = false, -- Enable transparent background (true/false)
  terminal_colors = true, -- Enable terminal colors
})

-- Set colorscheme
vim.cmd [[colorscheme tokyonight]]

-- Lualine Configuration
require('lualine').setup {
  options = {
    theme = 'tokyonight',                        -- Set Lualine to use Tokyo Night theme
    section_separators = '',
    component_separators = ''
  }
}

-- Nvim-tree Configuration
require('nvim-tree').setup {
  view = { width = 30, side = 'left' },
  update_cwd = true,
}

-- Gitsigns Configuration
require('gitsigns').setup()

-- Key Mappings
local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

-- Key Mappings for Plugins
map('n', '<leader>e', ':NvimTreeToggle<CR>', opts) -- Toggle file tree
map('n', '<leader>ff', ':FZF<CR>', opts)           -- Fuzzy find files
map('n', '<leader>fg', ':GFiles<CR>', opts)        -- Fuzzy find git files
map('n', '<leader>fb', ':Buffers<CR>', opts)       -- Fuzzy find buffers
map('n', '<leader>gs', ':Gitsigns toggle_signs<CR>', opts) -- Toggle Git signs

-- Additional Productivity Mappings
map('n', '<leader>h', ':noh<CR>', opts)            -- Clear search highlights
map('n', '<leader>w', ':w<CR>', opts)              -- Save file
map('n', '<leader>q', ':q<CR>', opts)              -- Quit
map('n', '<leader>c', ':bd<CR>', opts)             -- Close buffer
map('n', '<leader>s', ':split<CR>', opts)          -- Horizontal split
map('n', '<leader>v', ':vsplit<CR>', opts)         -- Vertical split

