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
   files = {
      cwd_prompt = false,
      hidden = true,
   },
   fzf_colors = true,
   defaults = {
      formatter = "path.dirname_first", -- show greyed-out directory before filename
   },
   winopts = {
      border = "single",
      preview = {
         border = "border",
         wrap = "nowrap",
         scrollbar = "false",
         layout = "horizontal",
         horizontal = "right:50%",
      },
   },
   actions = {
      files = {
         true,
         ["default"] = function(selected, opts)
            -- Find a non-NvimTree window in the CURRENT TAB only
            for _, win in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
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
      ["--no-info"] = true,
      ["--border"] = "none",
      ["--no-separator"] = true,
      ["--no-scrollbar"] = true,
   },
   fzf_tmux_opts = { ["-p"] = "80%,80%", ["--margin"] = "0,0" },
   keymap = {
      buitin = {
         true,
         ["<F1>"] = "toggle-help",
         ["<F2>"] = "toggle-fullscreen",
         -- Only valid with the 'builtin' previewer
         ["<F3>"] = "toggle-preview-wrap",
         ["<F4>"] = "toggle-preview",
         ["<S-Left>"] = "preview-reset",
         ["<S-down>"] = "preview-page-down",
         ["<S-up>"] = "preview-page-up",
         ["<M-S-down>"] = "preview-down",
         ["<M-S-up>"] = "preview-up",
      },
      fzf = {
         true,
      },
   },
}
