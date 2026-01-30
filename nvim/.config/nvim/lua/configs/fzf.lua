---@module "fzf-lua"
---@type fzf-lua.Config|{}
---@diagnostic disable: missing-fields
return {
   "telescope",
   hls = {
      border = "FloatBorder",
      normal = "Normal",
      preview_normal = "Normal",
      preview_border = "FloatBorder",
   },
   winopts = {
      border = "rounded",
      preview = {
         border = "rounded",
         scrollbar = "false",
         layout = "horizontal",
         horizontal = "right:50%",
      },
   },
   actions = {
      files = {
         ["default"] = function(selected, opts)
            -- Find a non-NvimTree window
            for _, win in ipairs(vim.api.nvim_list_wins()) do
               local buf = vim.api.nvim_win_get_buf(win)
               local ft = vim.bo[buf].filetype
               if ft ~= "NvimTree" and vim.api.nvim_win_get_config(win).relative == "" then
                  vim.api.nvim_set_current_win(win)
                  break
               end
            end
            require("fzf-lua.actions").file_edit(selected, opts)
         end,
      },
   },
   ---@diagnostic enable: missing-fields
   -- Enable fzf-native for better performance
   fzf_opts = {
      ["--layout"] = "reverse",
      ["--info"] = "inline-right",
      ["--height"] = "90%",
   },
   keymap = {
      buitin = {
         true,
      },
      fzf = {
         true,
      },
   },
}
