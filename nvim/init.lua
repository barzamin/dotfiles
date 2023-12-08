-- vim: ts=2 sts=2 sw=2 et

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

vim.g.mapleader = ','

require("lazy").setup({
  -- rice
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {},
  },
  {
    'Yggdroot/indentLine',
    lazy = false,
  },
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
  },
  -- editing
  { 'tpope/vim-rsi' },
  -- search/nav
  {
    'nvim-telescope/telescope.nvim', tag = '0.1.4',
    dependencies = { 'nvim-lua/plenary.nvim' }
  },
  -- lsp and syntaxes
  { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" }
})

-- rice
vim.g.colorcolumn = 80
require("tokyonight").setup({
  style="moon"
})
vim.cmd[[colorscheme tokyonight]]

require('lualine').setup({
  options = {
    theme = 'tokyonight'
  }
})

-- search/nav
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
