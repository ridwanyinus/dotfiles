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
      opts = {
         reload_on_bufenter = true,
         sync_root_with_cwd = false,
         respect_buf_cwd = false,
         auto_reload_on_write = true,
         hijack_directories = {
            enable = false,
            auto_open = true,
         },
         actions = {
            open_file = {
               quit_on_open = false,
               resize_window = false,
               window_picker = {
                  enable = false,
               },
            },
         },
         update_focused_file = {
            enable = false,
         },
         git = {
            ignore = false,
         },
         view = {
            signcolumn = "no",
            centralize_selection = true,
            adaptive_size = false,
            side = "right",
            preserve_window_proportions = true,
            width = 25,
            float = {
               enable = true,
               quit_on_focus_loss = false,
               open_win_config = function()
                  local screen_height = vim.o.lines - 4

                  return {
                     row = 0,
                     width = 25,
                     border = "rounded",
                     relative = "editor",
                     col = vim.o.columns,
                     height = screen_height,
                  }
               end,
            },
         },
         renderer = {
            highlight_git = true,
            icons = {
               show = {
                  git = true,
               },
            },
         },
      },
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
  cmd = { "Mason", "MasonInstall", "MasonUpdate" },
  opts = {
    -- ensure_installed = {
    --   "lua-language-server",
    --   "stylua",
    --   "html-lsp",
    --   "css-lsp",
    --   "typescript-language-server",
    --   "biome",
    -- },
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
      ---@module "fzf-lua"
      ---@type fzf-lua.Config|{}
      ---@diagnostic disable: missing-fields
      opts = {
         "telescope",
         hls = {
            border = "FloatBorder",
            normal = "Normal",
            preview_normal = "Normal",
         },
         winopts = {
            -- width = 0.90,
            -- height = 85,
            border = "rounded",
            preview = {
               layout = "horizontal",
               horizontal = "right:50%",
               winopts = {},
            },
         },
         keymap = {
            fzf = {
               ["<C-j>"] = "preview-down",
               ["<C-k>"] = "preview-up",
               ["<C-d>"] = "preview-page-down",
               ["<C-u>"] = "preview-page-up",
            },
         },
         actions = {
            files = {
               ["default"] = function(selected, opts)
                  -- Find a non-NvimTree window
                  for _, win in ipairs(vim.api.nvim_list_wins()) do
                     local buf = vim.api.nvim_win_get_buf(win)
                     local ft = vim.bo[buf].filetype
                     if ft ~= "NvimTree" and vim.api.nvim_win_get_config(win).relative == "" then
                        vim.api.nvim_set_current_win(win)
                        break
                     end
                  end
                  require("fzf-lua.actions").file_edit(selected, opts)
               end,
            },
         },
      },
      ---@diagnostic enable: missing-fields
      -- Enable fzf-native for better performance
      fzf_opts = {
         ["--layout"] = "reverse",
         ["--info"] = "inline-right",
         ["--height"] = "90%",
      },
   },
   {
      "m4xshen/hardtime.nvim",
      lazy = false,
      dependencies = { "MunifTanjim/nui.nvim" },
      opts = {},
   },
}
