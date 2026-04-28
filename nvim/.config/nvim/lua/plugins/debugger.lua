return {
   "mfussenegger/nvim-dap",
   enabled = false,
   dependencies = {
      "theHamsta/nvim-dap-virtual-text",
      "igorlfs/nvim-dap-view",
   },
   keys = {
      { "<leader>dt", "<cmd>DapViewToggle<CR>" },
      { "<leader>db", "<cmd>DapToggleBreakpoint<CR>" },
      { "<leader>dc", "<cmd>DapContinue<CR>" },
      { "<leader>dw", "<cmd>DapViewWatch<CR>" },
   },
   config = function()
      require("nvim-dap-virtual-text").setup()
   end,
}
