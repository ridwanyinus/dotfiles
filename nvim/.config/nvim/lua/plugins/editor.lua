return {
   {
      "m4xshen/hardtime.nvim",
      event = { "BufReadPre", "BufNewFile" },
      dependencies = { "MunifTanjim/nui.nvim" },
      opts = {},
   },
   {
      "nvim-mini/mini.surround",
      event = { "BufReadPre", "BufNewFile" },
      version = false,
      config = function()
         require("mini.surround").setup {
            custom_surroundings = nil,
            highlight_duration = 500,

            mappings = {
               add = "sa", -- Add surrounding
               delete = "sd", -- Delete surrounding
               find = "sf", -- Find surrounding (to the right)
               find_left = "sF", -- Find surrounding (to the left)
               highlight = "sh", -- Highlight surrounding
               replace = "sr", -- Replace surrounding
               update_n_lines = "sn", -- Update `n_lines`

               suffix_last = "l", -- Suffix to search with "prev" method
               suffix_next = "n", -- Suffix to search with "next" method
            },
            n_lines = 20,
            respect_selection_type = false,
            search_method = "cover",
            silent = false,
         }
      end,
   },
   {
      {
         "abecodes/tabout.nvim",
         config = function()
            require("tabout").setup {
               tabkey = "<Tab>", -- key to trigger tabout, set to an empty string to disable
               backwards_tabkey = "<S-Tab>", -- key to trigger backwards tabout, set to an empty string to disable
               act_as_tab = true, -- shift content if tab out is not possible
               act_as_shift_tab = false, -- reverse shift content if tab out is not possible (if your keyboard/terminal supports <S-Tab>)
               default_tab = "<C-t>", -- shift default action (only at the beginning of a line, otherwise <TAB> is used)
               default_shift_tab = "<C-d>", -- reverse shift default action,
               enable_backwards = true, -- well ...
               completion = false, -- if the tabkey is used in a completion pum
               tabouts = {
                  { open = "'", close = "'" },
                  { open = '"', close = '"' },
                  { open = "`", close = "`" },
                  { open = "(", close = ")" },
                  { open = "[", close = "]" },
                  { open = "{", close = "}" },
               },
               ignore_beginning = true, --[[ if the cursor is at the beginning of a filled element it will rather tab out than shift the content ]]
               exclude = {}, -- tabout will ignore these filetypes
            }
         end,
         opt = true, -- Set this to true if the plugin is optional
         event = "InsertEnter", -- Set the event to 'InsertCharPre' for better compatibility
         priority = 1000,
      },
   },
   {
      "nvim-treesitter/nvim-treesitter-textobjects",
      branch = "main",
      config = function()
         require("nvim-treesitter-textobjects").setup {
            move = {
               set_jumps = true,
            },
            select = {
               lookahead = true,
               include_surrounding_whitespace = true,
               selection_modes = {
                  ["@parameter.outer"] = "v",
                  ["@function.outer"] = "V",
                  ["@conditional.outer"] = "V", -- Select the whole if-block linewise
                  ["@loop.outer"] = "V", -- Select the whole loop linewise
               },
            },
         }
      end,
   },
   {
      "Wansmer/treesj",
      keys = { "<space>m", "<space>j", "<space>s" },
      config = function()
         require("treesj").setup {}
      end,
   },
   {
      "windwp/nvim-ts-autotag",
      event = { "BufReadPre", "BufNewFile" },
      ft = {
         "javascript",
         "javascriptreact",
         "typescript",
         "typescriptreact",
      },
      opts = {
         opts = {
            enable_close_on_slash = true,
         },
      },
   },
   {
      "folke/noice.nvim",
      enable = false,
      event = "VeryLazy",
      opts = {
         lsp = {
            -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
            override = {
               ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
               ["vim.lsp.util.stylize_markdown"] = true,
            },
         },
         presets = {
            bottom_search = true, -- use a classic bottom cmdline for search
            command_palette = false, -- position the cmdline and popupmenu together
            long_message_to_split = true, -- long messages will be sent to a split
            inc_rename = false, -- enables an input dialog for inc-rename.nvim
            lsp_doc_border = false, -- add a border to hover docs and signature help
         },
         cmdline = {
            enabled = true,
            view = "cmdline",
         },
      },
   },
}
