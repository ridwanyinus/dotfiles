-- This file neiiiieds to have same structure as nvconfig.lua
-- https://github.com/NvChad/ui/blob/v3.0/lua/nvconfig.lua
-- Please read that file to know all available options :(
local stl_utils = require "nvchad.stl.utils"

local stbufnr = function()
   return vim.api.nvim_win_get_buf(vim.g.statusline_winid or 0)
end

local ascii = require "ascii"

local git_fn = function()
   if
      not vim.b[vim.api.nvim_win_get_buf(vim.g.statusline_winid or 0)].gitsigns_head
      or vim.b[vim.api.nvim_win_get_buf(vim.g.statusline_winid or 0)].gitsigns_git_status
   then
      return ""
   end

   local git_status = vim.b[vim.api.nvim_win_get_buf(vim.g.statusline_winid or 0)].gitsigns_status_dict

   local branch_name = " " .. git_status.head

   return "" .. branch_name
end

local M = {}
M.base46 = {
   theme = "chadwal",
   theme_toggle = { "monekai", "chadwal" },
   transparency = true,
   hl_override = {
      Comment = { italic = true, fg = "#7a8194" },
      ["@comment"] = { italic = true },

      ["@keyword"] = { italic = true },
      ["@function.method"] = { italic = true },
      ["@function.method.call"] = { bold = true },
   },
   integrations = { "semantic_tokens" },
   -- excluded = { "whichkey", "telescope", "tbline", "nvimtree", "nvcheatsheet", "mason", "git" },
}

M.nvdash = {
   load_on_startup = true,
   header = ascii.miyamoto_musashi,

   buttons = {
      { txt = "  Find File", keys = "f", cmd = "FzfLua files" },
      { txt = "  Find Directories", keys = "d", cmd = "lua require('custom.utils').fzf_focus_nvimtree()" },
      { txt = "  Recent Files", keys = "o", cmd = "FzfLua oldfiles" },

      { txt = "─", hl = "NvDashFooter", no_gap = true, rep = true },

      {
         txt = function()
            local stats = require("lazy").stats()
            local ms = math.floor(stats.startuptime) .. " ms"
            return "  Loaded " .. stats.loaded .. "/" .. stats.count .. " plugins in " .. ms
         end,
         hl = "NvDashFooter",
         no_gap = true,
         content = "fit",
      },

      { txt = "─", hl = "NvDashFooter", no_gap = true, rep = true },
   },
}

M.ui = {
   tabufline = {
      lazyload = false,
   },

   statusline = {
      separator_style = "block",
      theme = "minimal",
      order = { "mode", "cgit", "%=", "lsp_msg", "%=", "lsp", "cwd" },
      modules = {
         mode = function()
            if not stl_utils.is_activewin() then
               return ""
            end

            local modes = stl_utils.modes
            local m = vim.api.nvim_get_mode().mode

            local config = require("nvconfig").ui.statusline
            local sep_style = config.separator_style
            sep_style = (sep_style ~= "round" and sep_style ~= "block") and "block" or sep_style

            local sep_icons = stl_utils.separators
            local separators = (type(sep_style) == "table" and sep_style) or sep_icons[sep_style]

            local sep_r = "%#St_sep_r#" .. separators["right"] .. " %#ST_EmptySpace#"

            local mode_name = modes[m][2]
            local hl_text = "%#St_" .. mode_name .. "ModeText#"

            return hl_text .. " " .. modes[m][1] .. sep_r
         end,
         cgit = function()
            return "%#St_gitIcons#" .. git_fn()
         end,
         lsp = function()
            if not rawget(vim, "lsp") then
               return ""
            end

            local blacklist = { "stylelint_lsp", "tailwindcss", "emmet_ls", "eslint", "null-ls" }

            for _, client in ipairs(vim.lsp.get_clients()) do
               local is_blacklisted = vim.tbl_contains(blacklist, client.name)

               if client.attached_buffers[stbufnr()] and not is_blacklisted then
                  return (vim.o.columns > 100 and "lsp   " .. client.name .. " ") or "   lsp "
               end
            end

            return ""
         end,
      },
   },

   cmp = {
      format_colors = {
         tailwind = true,
      },
      style = "catppuccin_colored",
      icons_left = true,
   },
}

M.cheatsheet = {
   theme = "simple", -- simple/grid
}

M.term = {
   sizes = { sp = 0.4, vsp = 0.5, ["bo sp"] = 0.3, ["bo vsp"] = 0.2 },
   float = {
      relative = "editor",
      width = 0.6,
      height = 0.5,
      col = 0.2,
      row = 0.25,
      border = "single",
   },
}

return M
