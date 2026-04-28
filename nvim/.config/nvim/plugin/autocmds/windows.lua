local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

autocmd("VimResized", {
   desc = "Resize splits when the terminal emulator window is resized.",
   group = vim.api.nvim_create_augroup("EqualizeSplits", { clear = true }),
   callback = function()
      local current_tab = vim.api.nvim_get_current_tabpage()

      vim.cmd "tabdo wincmd ="
      vim.api.nvim_set_current_tabpage(current_tab)
   end,
})

autocmd({ "WinEnter", "BufEnter" }, {
   desc = "Show cursorline in active window.",
   group = vim.api.nvim_create_augroup("active_cursorline", { clear = true }),
   callback = function()
      vim.opt_local.cursorline = true
   end,
})

autocmd({ "WinLeave", "BufLeave" }, {
   desc = "Hide cursorline in inactive windows.",
   group = "active_cursorline",
   callback = function()
      vim.opt_local.cursorline = false
   end,
})

autocmd("BufWritePre", {
   group = augroup("auto_create_dir", { clear = true }),
   callback = function(event)
      if event.match:match "^%w%w+://" then
         return
      end
      local file = vim.uv.fs_realpath(event.match) or event.match
      vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
   end,
})
