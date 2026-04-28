require "nvchad.autocmds"

local api = vim.api
local autocmd = api.nvim_create_autocmd
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

autocmd("FileType", {
   desc = "Disable automatic comment insertion on new lines.",
   group = vim.api.nvim_create_augroup("AutoNoAutoComment", { clear = true }),
   callback = function()
      vim.opt_local.formatoptions:remove { "c", "r", "o" }
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

autocmd("FileType", {
   pattern = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
   callback = function()
      vim.opt_local.tabstop = 4
      vim.opt_local.shiftwidth = 4
      vim.opt_local.expandtab = false -- Ensure we use real tabs, not spaces
   end,
})

vim.api.nvim_create_autocmd("FileType", {
   pattern = "*",
   callback = function()
      if pcall(vim.treesitter.start) then
         -- Indent expérimental
         -- vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
         -- Folds
         vim.wo[0][0].foldmethod = "expr"
         vim.wo[0][0].foldexpr = "v:lua.vim.treesitter.foldexpr()"
      end
   end,
})

-- Close certain filetypes with q
-- Note: 'man' is excluded because Neovim has built-in q handling for man pages
autocmd("FileType", {
   group = api.nvim_create_augroup("close_with_q", { clear = true }),
   pattern = {
      "checkhealth",
      "git",
      "gitsigns-blame",
      "help",
      "lspinfo",
      "notify",
      "qf",
      "startuptime",
   },
   callback = function(event)
      vim.bo[event.buf].buflisted = false
      vim.keymap.set("n", "q", function()
         local ok = pcall(vim.cmd.bdelete, { bang = true })
         if not ok then
            vim.cmd.quit()
         end
      end, { buffer = event.buf, silent = true, desc = "Close buffer" })
   end,
})

vim.api.nvim_create_autocmd("FileType", {
   pattern = "msg",
   callback = function()
      local ui2 = require "vim._core.ui2"
      local win = ui2.wins and ui2.wins.msg
      if win and vim.api.nvim_win_is_valid(win) then
         vim.api.nvim_set_option_value("winhighlight", "Normal:NormalFloat,FloatBorder:FloatBorder", { scope = "local", win = win })
      end
   end,
})

local ui2 = require "vim._core.ui2"
local msgs = require "vim._core.ui2.messages"
local orig_set_pos = msgs.set_pos
msgs.set_pos = function(tgt)
   orig_set_pos(tgt)
   if (tgt == "msg" or tgt == nil) and vim.api.nvim_win_is_valid(ui2.wins.msg) then
      pcall(vim.api.nvim_win_set_config, ui2.wins.msg, {
         relative = "editor",
         anchor = "NE",
         row = 1,
         col = vim.o.columns - 1,
         border = "rounded",
      })
   end
end

vim.api.nvim_create_autocmd("WinEnter", {
   pattern = { "*" },
   group = api.nvim_create_augroup("close_with_q", { clear = true }),
   callback = function()
      vim.fn.matchadd("TODO", "TODO:")
      vim.fn.matchadd("INFO", "INFO:")
      vim.fn.matchadd("FIX", "FIX:")
      vim.fn.matchadd("BUG", "BUG:")
   end,
   desc = "Make the matches for the nanos colorscheme Special Comments at every window",
})
