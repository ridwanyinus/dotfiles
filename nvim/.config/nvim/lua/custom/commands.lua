local create_cmd = vim.api.nvim_create_user_command

create_cmd("KebabToCamel", [[s/\([a-zA-Z]\)\(-\)\([a-zA-Z]\)/\1\u\3/g]], { desc = "Line: kebab to camel" })
create_cmd("RefactorNumbers", [[s/\d\+/number/g]], { desc = "Line: digits to 'number'" })
create_cmd("RefactorStrings", [[s/"[^"]*"/string/g]], { desc = "Line: quotes to 'string'" })
create_cmd("RefactorBooleans", [[s/\v(true|false)/boolean/g]], { desc = "Line: bools to 'boolean'" })

create_cmd("ReplaceAll", function(opts)
   local word = vim.fn.expand "<cword>"
   -- Change to '%%s' if you want it to be the whole file, or 's' for current line
   vim.cmd(string.format([[%%s/\<%s\>/%s/gc]], word, opts.args))
end, { nargs = 1, desc = "File: replace word under cursor with new word" })

create_cmd("FoldTag", "normal vatzf", {})
create_cmd("FoldBlock", "normal vaBzf", {})

create_cmd("GitBlame", "Gitsigns blame_line", {})
create_cmd("Diagnostics", function()
   vim.diagnostic.open_float()
end, {})

create_cmd("ToggleInlayHints", function()
   vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = 0 }, { bufnr = 0 })
end, { desc = "Toggle inlay hints" })

-- Close all buffers except current
create_cmd("CloseOtherBuffers", function()
   local current = vim.api.nvim_get_current_buf()
   for _, buf in ipairs(vim.api.nvim_list_bufs()) do
      if buf ~= current and vim.api.nvim_buf_is_loaded(buf) then
         vim.api.nvim_buf_delete(buf, { force = false })
      end
   end
end, {})

-- Close all buffers except current
create_cmd("CloseOtherBuffers", function()
   local current = vim.api.nvim_get_current_buf()
   for _, buf in ipairs(vim.api.nvim_list_bufs()) do
      if buf ~= current and vim.api.nvim_buf_is_loaded(buf) then
         local bufname = vim.api.nvim_buf_get_name(buf)
         local is_terminal = bufname:match "^term://" ~= nil

         pcall(vim.api.nvim_buf_delete, buf, { force = is_terminal })
      end
   end
end, {})

-- Close ALL buffers
create_cmd("CloseAllBuffers", function()
   for _, buf in ipairs(vim.api.nvim_list_bufs()) do
      if vim.api.nvim_buf_is_loaded(buf) then
         local bufname = vim.api.nvim_buf_get_name(buf)
         local is_terminal = bufname:match "^term://" ~= nil

         pcall(vim.api.nvim_buf_delete, buf, { force = is_terminal })
      end
   end
end, {})
