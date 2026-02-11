return {
   {
      "NickvanDyke/opencode.nvim",
      dependencies = {
         { "folke/snacks.nvim", opts = { input = {}, picker = {}, terminal = {} } },
      },
      keys = {
         {
            "<leader>oc",
            function()
               require("opencode").ask()
            end,
         },
         {
            "<leader>oc",
            function()
               require("opencode").ask "@this: "
            end,
            mode = "v",
         },
         {
            "<leader>op",
            function()
               require("opencode").select()
            end,
         },
      },
   },
   {
      "supermaven-inc/supermaven-nvim",
      event = "InsertEnter",
      opts = {
         keymaps = {
            accept_suggestion = "<A-f>",
            clear_suggestion = "<C-]>",
            accept_word = "<C-j>",
         },
      },
   },
   {
      "monkoose/neocodeium",
      enabled = false,

      event = "VeryLazy",
      config = function()
         local neocodeium = require "neocodeium"
         neocodeium.setup()
         vim.keymap.set("i", "<A-f>", neocodeium.accept)
      end,
   },
}
