return {
   {
      "NickvanDyke/opencode.nvim",
      enabled = false,
      event = "VeryLazy",
      version = "*", -- Latest stable release
      dependencies = {
         {
            -- `snacks.nvim` integration is recommended, but optional
            ---@module "snacks" <- Loads `snacks.nvim` types for configuration intellisense
            "folke/snacks.nvim",
            optional = true,
            opts = {
               input = {}, -- Enhances `ask()`
               picker = { -- Enhances `select()`
                  actions = {
                     opencode_send = function(...)
                        return require("opencode").snacks_picker_send(...)
                     end,
                  },
                  win = {
                     input = {
                        keys = {
                           ["<a-a>"] = { "opencode_send", mode = { "n", "i" } },
                        },
                     },
                  },
               },
               terminal = {}, -- Enables the `snacks` provider
            },
         },
      },
      config = function()
         ---@type opencode.Opts
         vim.g.opencode_opts = {}

         vim.o.autoread = true

         vim.keymap.set({ "n" }, "<leader>oc", function()
            require("opencode").ask()
         end, { desc = "Ask opencode…" })
         vim.keymap.set({ "x" }, "<leader>oc", function()
            require("opencode").ask("@this: ", { submit = true })
         end, { desc = "Ask opencode…" })
         vim.keymap.set({ "n", "x" }, "<leader>op", function()
            require("opencode").select()
         end, { desc = "Execute opencode action…" })
         vim.keymap.set({ "n", "t" }, "<C-.>", function()
            require("opencode").toggle()
         end, { desc = "Toggle opencode" })

         vim.keymap.set({ "n", "x" }, "go", function()
            return require("opencode").operator "@this "
         end, { desc = "Add range to opencode", expr = true })
         vim.keymap.set("n", "goo", function()
            return require("opencode").operator "@this " .. "_"
         end, { desc = "Add line to opencode", expr = true })

         vim.keymap.set("n", "<S-C-u>", function()
            require("opencode").command "session.half.page.up"
         end, { desc = "Scroll opencode up" })
         vim.keymap.set("n", "<S-C-d>", function()
            require("opencode").command "session.half.page.down"
         end, { desc = "Scroll opencode down" })
      end,
   },
   {
      "supermaven-inc/supermaven-nvim",
      enabled = false,
      event = "InsertEnter",
      opts = {
         keymaps = {
            accept_suggestion = "<A-f>",
            clear_suggestion = "<C-]>",
            accept_word = "<C-j>",
         },
         disable_inline_completion = false, -- disables inline completion for use with cmp
         ignore_filetypes = { cpp = true }, -- or { "cpp", }
      },
   },
   {
      "monkoose/neocodeium",

      event = "VeryLazy",
      config = function()
         local neocodeium = require "neocodeium"
         neocodeium.setup()
         vim.keymap.set("i", "<A-f>", neocodeium.accept)
      end,
   },
}
