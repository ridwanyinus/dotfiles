return {
   "ibhagwan/fzf-lua",
   cmd = "FzfLua",
   dependencies = {
      "MeanderingProgrammer/render-markdown.nvim",
   },
   opts = function()
      return require "configs.fzf"
   end,
}
