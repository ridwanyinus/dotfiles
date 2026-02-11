local M = {}

M.fzf_focus_nvimtree = function()
   require("fzf-lua").files {
      cmd = "fd --type d --exclude node_modules --exclude .next --exclude .git",
      previewer = false,
      winopts = {
         title = " Focus Directory ",
         width = 0.4,
      },
      actions = {
         ["default"] = function(selected)
            if selected and selected[1] then
               local path = require("fzf-lua").path.entry_to_file(selected[1]).path
               local api = require "nvim-tree.api"
               api.tree.open()
               api.tree.find_file(path)
            end
         end,
      },
   }
end

M.nav_dir_files = function(count)
   local curfile = vim.fn.expand "%:p"
   local curdir = vim.fn.expand "%:p:h"
   -- Get all files in current directory (excluding folders)
   local files = vim.fn.glob(curdir .. "/*", false, true)
   local filtered = {}

   for _, f in ipairs(files) do
      if vim.fn.isdirectory(f) == 0 then
         table.insert(filtered, vim.fn.fnamemodify(f, ":p"))
      end
   end

   local filelen = #filtered
   if filelen == 0 then
      return
   end

   -- Find current file index
   local curidx = -1
   for i, f in ipairs(filtered) do
      if f == curfile then
         curidx = i
         break
      end
   end

   if curidx == -1 then
      return
   end

   -- Calculate new index with wrapping
   local newidx = (curidx + count - 1) % filelen + 1
   if newidx <= 0 then
      newidx = newidx + filelen
   end

   vim.cmd("e " .. filtered[newidx])
end

return M
