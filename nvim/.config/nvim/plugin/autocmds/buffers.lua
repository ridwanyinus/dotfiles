local api = vim.api
local autocmd = api.nvim_create_autocmd

-- Briefly highlight yanked (copied) text for visual feedback
autocmd("TextYankPost", {
   pattern = "*",
   command = "silent! lua vim.highlight.on_yank({ timeout = 200 })",
   desc = "highlight yanked text",
})

autocmd("BufReadPost", {
   desc = "Block changes to read-only buffers.",
   group = vim.api.nvim_create_augroup("BlockReadOnly", { clear = true }),
   callback = function()
      local readonly = vim.api.nvim_get_option_value("readonly", { scope = "local" })
      vim.api.nvim_set_option_value("modifiable", not readonly, { scope = "local" })
   end,
})

-- restore cursor to file position in previous editing session
autocmd("BufReadPost", {
   desc = "Restore cursor to file position in previous editing session.",
   pattern = "*",
   callback = function(args)
      if vim.bo.buftype ~= "" then
         return
      end

      local mark = vim.api.nvim_buf_get_mark(args.buf, '"')
      local line_count = vim.api.nvim_buf_line_count(args.buf)

      if mark[1] > 1 and mark[1] <= line_count and not vim.tbl_contains({ "commit", "gitrebase", "xxd", "diff" }, vim.bo.filetype) then
         vim.cmd 'normal! g`"zz'
      end
   end,
})

autocmd("BufEnter", {
   desc = "Set winfixbuf for quickfix buffers.",
   group = vim.api.nvim_create_augroup("QuickfixWinFixBuf", { clear = true }),
   callback = function()
      if vim.list_contains({ "qf" }, vim.bo.filetype) then
         vim.opt_local.winfixbuf = true
      end
   end,
})

-- show dashboard when no open buffers
autocmd("BufDelete", {
   callback = function()
      local bufs = vim.t.bufs
      if #bufs == 1 and vim.api.nvim_buf_get_name(bufs[1]) == "" then
         vim.cmd "Nvdash"
      end
   end,
})

-- syntax highlighting for dotenv files
autocmd("BufRead", {
   group = vim.api.nvim_create_augroup("dotenv_ft", { clear = true }),
   pattern = { ".env", ".env.*" },
   callback = function()
      vim.bo.filetype = "dosini"
   end,
})

-- exclude terminal buffers from oldfiles
autocmd("TermOpen", {
   callback = function()
      vim.opt_local.buflisted = false
   end,
})

-- Disable persistent undo for sensitive files
---@type string[]
local sensitive_patterns = {
   -- Temp directories
   "/tmp/*",
   "/private/tmp/*", -- macOS
   "$TMPDIR/*",
   "/var/tmp/*",

   -- Environment files
   ".env",
   ".env.*",
   "*.env",
   "*/.env",
   "*/.env.*",

   -- SSH and GPG
   "*/.ssh/*",
   "*/.gnupg/*",

   -- Credentials and keys
   "*_rsa",
   "*_ed25519",
   "*_ecdsa",
   "*_dsa",
   "*.pem",
   "*.key",
   "*.p12",
   "*.pfx",
   "*.crt",
   "*.cer",
}

autocmd({ "BufReadPost", "BufNewFile" }, {
   group = vim.api.nvim_create_augroup("NoUndoSensitive", { clear = true }),
   pattern = sensitive_patterns,
   desc = "Disable undofile for sensitive paths.",
   callback = function()
      vim.bo.undofile = false
   end,
})
