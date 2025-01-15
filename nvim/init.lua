-- vim: ts=2 sts=2 sw=2 et

-- bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

vim.g.mapleader = ','

require("lazy").setup({
  spec = {
    -- utility
    {
      "folke/snacks.nvim",
      priority = 1000,
      lazy = false,
      opts = {
        indent = {
          enabled = true,
        },
        input = {
          enabled = true,
        },
      },
    },
    {
      "folke/which-key.nvim",
      event = "VeryLazy",
    },


    -- rice
    {
      "folke/tokyonight.nvim",
      lazy = false,
      priority = 1500,
      opts = {},
    },
    {
      "nvim-lualine/lualine.nvim",
      dependencies = { "nvim-tree/nvim-web-devicons" },
    },

    -- search/nav
    {
      "ibhagwan/fzf-lua",
      dependencies = { "echasnovski/mini.icons" },
      keys = {
        { "<leader>ff", "<cmd>FzfLua files<cr>", desc = "Find files" },
        { "<leader>fg", "<cmd>FzfLua live_grep<cr>", desc = "Live grep" },
        { "<leader>fb", "<cmd>FzfLua buffers<cr>", desc = "Find buffers" },
      },
    },

    -- lsp and syntaxes
    { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },

    -- completion
    {
      'saghen/blink.cmp',
      version = '*',
      opts = {
        keymap = {
          preset = "super-tab",
        },
        sources = {
          default = { "lsp", "path", "snippets", "buffer" },
        },
        fuzzy = {
          prebuilt_binaries = {
            download = false, -- do it manually; glib incompatibility :(
          },
        },
      },
      opts_extend = { "sources.default" }
    },
  },
  checker = { enabled = true },
})

-- rice
vim.g.colorcolumn = 80
require("tokyonight").setup({
  style="moon"
})
vim.cmd[[colorscheme tokyonight]]

require('lualine').setup({
  options = {
    theme = 'auto',

    icons_enabled = false,
    section_separators = '',
    component_separators = '',
  }
})

