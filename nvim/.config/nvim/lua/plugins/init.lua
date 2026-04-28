return {

   { "nvim-telescope/telescope.nvim", enabled = false },
   { "hrsh7th/nvim-cmp", enabled = false },
   { "hrsh7th/cmp-buffer", enabled = false },
   { "hrsh7th/cmp-path", enabled = false },
   { "hrsh7th/cmp-nvim-lsp", enabled = false },
   -- { "lukas-reineke/indent-blankline.nvim", enabled = false },
   -- { "saadparwaiz1/cmp_luasnip", enabled = false },

   { "wakatime/vim-wakatime", lazy = false },

   {
      "neovim/nvim-lspconfig",
      config = function()
         require "configs.lspconfig"
      end,
   },
   {
      "nvim-tree/nvim-tree.lua",
      build = ":TSUpdate",
      opts = require "configs.nvimtree",
   },
   {
      "saghen/blink.cmp",
      version = "1.*",
      event = { "InsertEnter" },
      dependencies = {
         "rafamadriz/friendly-snippets",

         {
            "windwp/nvim-autopairs",
            opts = {
               fast_wrap = {},
               disable_filetype = { "vim" },
            },
         },
      },
      opts_extend = { "sources.default" },
      opts = function()
         return require "configs.blink"
      end,
   },
   {
      "nvim-treesitter/nvim-treesitter",
      lazy = false,
      opts = require "configs.treesitter",
   },
}
