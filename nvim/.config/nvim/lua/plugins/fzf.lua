return {
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
}
