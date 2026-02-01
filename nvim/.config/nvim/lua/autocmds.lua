require "nvchad.autocmds"

local api = vim.api
local autocmd = vim.api.nvim_create_autocmd

-- Automatically change working directory to the directory of the opened file on startup
api.nvim_create_autocmd("VimEnter", {
   callback = function()
      -- Only change cwd on startup when opening a file/directory
      if vim.fn.argc() > 0 then
         vim.cmd "silent! lcd %:p:h"
      end
   end,
})

-- Helper function: Check if any real (non-special) buffers are currently open
-- Returns true if there are listed buffers with content, false otherwise
local function has_real_buffers()
   local buffers = api.nvim_list_bufs()
   local real_buffers = 0
   for _, buf in ipairs(buffers) do
      if api.nvim_buf_is_valid(buf) and api.nvim_buf_is_loaded(buf) then
         local buftype = api.nvim_get_option_value("buftype", { buf = buf })
         local bufname = api.nvim_buf_get_name(buf)
         local listed = api.nvim_get_option_value("buflisted", { buf = buf })
         -- Count only normal file buffers (not terminals, help, etc.)
         if buftype == "" and listed then
            if bufname ~= "" or api.nvim_get_option_value("modified", { buf = buf }) then
               real_buffers = real_buffers + 1
            end
         end
      end
   end
   return real_buffers > 0
end

-- Automatically show dashboard when the last real buffer is closed
-- Triggers on buffer delete or wipeout events
api.nvim_create_autocmd({ "BufDelete", "BufWipeout" }, {
   group = api.nvim_create_augroup("ShowDashboard", { clear = true }),
   callback = function(args)
      -- Ignore special buffer types (terminals, help, etc.)
      local buftype = api.nvim_get_option_value("buftype", { buf = args.buf })
      if buftype ~= "" then
         return
      end
      -- Schedule check to happen after buffer is fully deleted
      vim.schedule(function()
         vim.defer_fn(function()
            -- If no real buffers remain, open the dashboard
            if not has_real_buffers() then
               local current_buf = api.nvim_get_current_buf()
               local current_ft = api.nvim_get_option_value("filetype", { buf = current_buf })
               -- Avoid opening dashboard if already on dashboard
               if current_ft ~= "nvdash" then
                  vim.cmd "Nvdash"
               end
            end
         end, 10)
      end)
   end,
})

-- Briefly highlight yanked (copied) text for visual feedback
autocmd("TextYankPost", {
   pattern = "*",
   command = "silent! lua vim.highlight.on_yank({ timeout = 100 })",
})

-- Restore cursor position to last known location when opening a file
-- Jumps to the line where you last edited the file
autocmd("BufReadPost", {
   pattern = "*",
   callback = function()
      -- Check if the last position mark exists and is valid
      if vim.fn.line "'\"" > 1 and vim.fn.line "'\"" <= vim.fn.line "$" then
         vim.cmd 'exe "normal! g\'\\""'
      end
   end,
})

-- Create user command for finding directories
vim.api.nvim_create_user_command("FzfFindDirs", function()
   require("fzf-lua").files {
      cmd = "fd --type d --exclude node_modules --exclude .next --exclude .git",
      cwd_prompt = false,
      previewer = false,
      winopts = {
         width = 0.4,
      },
   }
end, {})
