return {
   {
      "kdheepak/lazygit.nvim",
      lazy = true,
      cmd = {
         "LazyGit",
         "LazyGitConfig",
         "LazyGitCurrentFile",
         "LazyGitFilter",
         "LazyGitFilterCurrentFile",
      },
      dependencies = {
         "nvim-lua/plenary.nvim",
      },
      keys = {
         { "<leader>lg", "<cmd>LazyGit<cr>", desc = "LazyGit" },
      },
   },
   {
      "lewis6991/gitsigns.nvim",
      opts = {
         current_line_blame_opts = {
            virt_text = true,
            virt_text_pos = "eol",
            delay = 500,
         },

         current_line_blame_formatter = " <author>, <author_time:%R>",
         preview_config = {
            border = "rounded", -- Options: "single", "double", "rounded", "solid", "shadow"
            style = "minimal",
            relative = "cursor",
            row = 0,
            col = 1,
         },
      },
   },
}
