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

create_cmd("CloseOtherBuffers", function()
   local current = vim.api.nvim_get_current_buf()
   for _, buf in ipairs(vim.api.nvim_list_bufs()) do
      if buf ~= current and vim.api.nvim_buf_is_loaded(buf) then
         vim.api.nvim_buf_delete(buf, { force = false })
      end
   end
end, {})

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

create_cmd("CloseAllBuffers", function()
   for _, buf in ipairs(vim.api.nvim_list_bufs()) do
      if vim.api.nvim_buf_is_loaded(buf) then
         local bufname = vim.api.nvim_buf_get_name(buf)
         local is_terminal = bufname:match "^term://" ~= nil

         pcall(vim.api.nvim_buf_delete, buf, { force = is_terminal })
      end
   end
end, {})

local live_server_id = nil

vim.api.nvim_create_user_command("LiveServerStart", function()
   if live_server_id then
      print "Live Server is already running!"
      return
   end

   local binary = "/home/ridwan/.local/share/pnpm/live-server"
   local port = "9000"

   local current_file = vim.fn.expand "%:t"

   local command = string.format("%s --port=%s --open=%s", binary, port, current_file)

   live_server_id = vim.fn.jobstart(command, {
      on_exit = function()
         live_server_id = nil
         print "Live Server stopped."
      end,
   })

   print("Live Server started at http://127.0.0.1:" .. port .. "/" .. current_file)
end, {})

vim.api.nvim_create_user_command("LiveServerStop", function()
   if live_server_id then
      vim.fn.jobstop(live_server_id)
      live_server_id = nil
   else
      print "Live Server is not running."
   end
end, {})

vim.api.nvim_create_user_command("TabOpen", function()
   vim.ui.input({ prompt = "File to open in new tab: ", completion = "file" }, function(input)
      if input and input ~= "" then
         vim.cmd("tabnew " .. input)
      end
   end)
end, { desc = "Open a file in a new tab using UI input" })

vim.api.nvim_create_user_command("TabDup", function()
   local current_file = vim.fn.expand "%:p"
   if current_file ~= "" then
      vim.cmd("tabnew " .. current_file)
   else
      vim.cmd "tabnew"
   end
end, { desc = "Duplicate current buffer in a new tab" })
