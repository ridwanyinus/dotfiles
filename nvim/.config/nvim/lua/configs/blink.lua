dofile(vim.g.base46_cache .. "blink")

local opts = {
   cmdline = { enabled = false },
   appearance = { nerd_font_variant = "mono" },
   fuzzy = { implementation = "rust" },
   sources = {
      default = { "lsp", "buffer", "snippets", "path" },
      per_filetype = {
         DressingInput = {}, -- disable autocomplete for NvimTree
      },
   },

   keymap = {
      preset = "default",
      ["<CR>"] = { "accept", "fallback" },
   },

   completion = {
      -- ghost_text = { enabled = true },
      documentation = {
         auto_show = false, -- use ctrl-space to toggle documentation instead
         auto_show_delay_ms = 200,
         window = { border = "single" },
      },

      -- nvchad's cmp ui
      menu = require("nvchad.blink").menu,
   },
}

return opts
