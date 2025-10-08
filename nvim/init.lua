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

-- packages
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
    {
      "folke/trouble.nvim",
      opts = {},
      cmd = "Trouble",
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
    {
      "nvim-treesitter/nvim-treesitter",
      build = ":TSUpdate",
      ensure_installed = {
        "c", "cpp",
        "lua",
        "python",
        "rust",
        "markdown", "markdown_inline",
        "vim", "vimdoc",
      },
    },
    { "williamboman/mason.nvim" },
    { "williamboman/mason-lspconfig.nvim" },
    { "neovim/nvim-lspconfig" },

    -- debugging
    { "mfussenegger/nvim-dap" },

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
        -- experimental
        signature = {
          enabled = true,
          window = {
            border = 'single',
            direction_priority = {'s','n'},
          },
        },
        fuzzy = {
          prebuilt_binaries = {
          },
        },
      },
      opts_extend = { "sources.default" }
    },

    -- llms :(
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

-- ui
vim.wo.number = true

-- lsp
require'mason'.setup{}
require'mason-lspconfig'.setup{}

require'lspconfig'.lua_ls.setup{}
require'lspconfig'.rust_analyzer.setup{}
require'lspconfig'.basedpyright.setup{}

