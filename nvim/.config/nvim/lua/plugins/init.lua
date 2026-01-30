return {
   -- Disable Telescope
   { "nvim-telescope/telescope.nvim", enabled = false },

   -- Disable nvim-cmp and its friends
   { "hrsh7th/nvim-cmp", enabled = false },
   { "hrsh7th/cmp-buffer", enabled = false },
   { "hrsh7th/cmp-path", enabled = false },
   { "hrsh7th/cmp-nvim-lsp", enabled = false },
   { "saadparwaiz1/cmp_luasnip", enabled = false },

   -- { "wakatime/vim-wakatime", lazy = false },
   { "vyfor/cord.nvim", build = ":Cord update", lazy = false },

   {
      "neovim/nvim-lspconfig",
      config = function()
         require "configs.lspconfig"
      end,
   },
   {
      "nvim-tree/nvim-tree.lua",
      opts = require "configs.nvimtree",
   },
   {
      "saghen/blink.cmp",
      version = "1.*",
      event = { "InsertEnter" },
      dependencies = {
         {
            "windwp/nvim-autopairs",
            opts = {
               fast_wrap = {},
               disable_filetype = { "TelescopePrompt", "vim" },
            },
         },
      },
      opts_extend = { "sources.default" },
      opts = function()
         return require "configs.blink"
      end,
   },
   {
      "stevearc/conform.nvim",
      event = { "BufWritePre" },
      cmd = { "ConformInfo" },
      opts = require "configs.conform",
   },
   {
      "mason-org/mason.nvim",
      opts = {
         ensure_installed = {
            "lua-language-server",
            "stylua",
            "html-lsp",
            "css-lsp",
            "typescript-language-server",
            "biome",
         },
      },
   },
   {
      "nvim-treesitter/nvim-treesitter",
      opts = {
         ensure_installed = {
            "vim",
            "vimdoc",
            "html",
            "css",
            "javascript",
            "typescript",
            "tsx",
            "bash",
            "fish",
         },
      },
   },

   {
      "ibhagwan/fzf-lua",
      cmd = "FzfLua",
      dependencies = {
         "nvim-mini/mini.icons",
         "mfussenegger/nvim-dap",
         "MeanderingProgrammer/render-markdown.nvim",
         "nvim-treesitter/nvim-treesitter-context",
      },
      opts = function()
         return require "configs.fzf"
      end,
   },
   {
      "m4xshen/hardtime.nvim",
      lazy = false,
      dependencies = { "MunifTanjim/nui.nvim" },
      opts = {},
   },
}
