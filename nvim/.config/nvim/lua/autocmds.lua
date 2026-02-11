require "nvchad.autocmds"

local api = vim.api
local autocmd = vim.api.nvim_create_autocmd
local highlight_group = api.nvim_create_augroup("LspReferenceHighlight", { clear = true })

-- Automatically change working directory to the directory of the opened file on startup
api.nvim_create_autocmd("VimEnter", {
   callback = function()
      -- Only change cwd on startup when opening a file/directory
      if vim.fn.argc() > 0 then
         vim.cmd "silent! lcd %:p:h"
      end
   end,
})

-- show dashboard when no open buffers
vim.api.nvim_create_autocmd("BufDelete", {
   callback = function()
      local bufs = vim.t.bufs
      if #bufs == 1 and vim.api.nvim_buf_get_name(bufs[1]) == "" then
         vim.cmd "Nvdash"
      end
   end,
})

-- Briefly highlight yanked (copied) text for visual feedback
autocmd("TextYankPost", {
   pattern = "*",
   command = "silent! lua vim.highlight.on_yank({ timeout = 200 })",
   desc = "highlight yanked text",
})

-- restore cursor to file position in previous editing session
autocmd("BufReadPost", {
   pattern = "*",
   callback = function()
      local line = vim.fn.line "'\""
      if
         line > 1
         and line <= vim.fn.line "$"
         and vim.bo.filetype ~= "commit"
         and vim.fn.index({ "xxd", "gitrebase" }, vim.bo.filetype) == -1
      then
         vim.cmd 'normal! g`"zz'
      end
   end,
})

-- auto resize splits when the window is resized
autocmd("VimResized", {
   command = "wincmd =",
})

-- no auto commenting on new line
autocmd("FileType", {
   group = api.nvim_create_augroup("no_auto_comment", {}),
   callback = function()
      vim.opt_local.formatoptions:remove { "c", "r", "o" }
   end,
})

-- syntax highlighting for dotenv files
autocmd("BufRead", {
   group = api.nvim_create_augroup("dotenv_ft", { clear = true }),
   pattern = { ".env", ".env.*" },
   callback = function()
      vim.bo.filetype = "dosini"
   end,
})

-- show cursorline only in active window
autocmd({ "WinEnter", "BufEnter" }, {
   group = api.nvim_create_augroup("active_cursorline", { clear = true }),
   callback = function()
      vim.opt_local.cursorline = true
   end,
})

-- hide cursorline in inactive windows
autocmd({ "WinLeave", "BufLeave" }, {
   group = "active_cursorline",
   callback = function()
      vim.opt_local.cursorline = false
   end,
})
