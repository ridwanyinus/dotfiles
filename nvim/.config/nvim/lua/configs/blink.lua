dofile(vim.g.base46_cache .. "blink")

local opts = {
   enabled = function()
      return not vim.tbl_contains({ "NvimTree", "neo-tree" }, vim.bo.filetype) and vim.bo.buftype ~= "prompt" and vim.bo.buftype ~= "nofile"
   end,
   cmdline = { enabled = false },
   appearance = { nerd_font_variant = "mono" },
   fuzzy = {
      sorts = {
         function(a, b)
            if (a.client_name == nil or b.client_name == nil) or (a.client_name == b.client_name) then
               return
            end
            return b.client_name == "emmet_ls"
         end,

         "exact",
         "score",
         "sort_text",
      },
   },
   sources = {
      per_filetype = {
         DressingInput = {}, -- disable autocomplete for NvimTree
      },
      providers = {
         buffer = {
            opts = {
               get_bufnrs = function()
                  return vim.tbl_filter(function(bufnr)
                     return vim.bo[bufnr].buftype == ""
                  end, vim.api.nvim_list_bufs())
               end,
            },
         },
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
   signature = { enabled = true, window = { border = "single" } },
}

return opts
