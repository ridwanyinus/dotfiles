vim.g.base46_cache = vim.fn.stdpath "data" .. "/base46/"
vim.g.mapleader = " "

-- bootstrap lazy and all plugins
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

if not vim.uv.fs_stat(lazypath) then
   local repo = "https://github.com/folke/lazy.nvim.git"
   vim.fn.system { "git", "clone", "--filter=blob:none", repo, "--branch=stable", lazypath }
end

vim.opt.rtp:prepend(lazypath)

local lazy_config = require "configs.lazy"

-- load plugins
require("lazy").setup({
   {
      "NvChad/NvChad",
      lazy = false,
      branch = "v2.5",
      import = "nvchad.plugins",
   },

   { import = "plugins" },
}, lazy_config)

-- load theme
dofile(vim.g.base46_cache .. "defaults")
dofile(vim.g.base46_cache .. "statusline")

require "options"
require "autocmds"

vim.schedule(function()
   require "mappings"
end)

os.execute "python ~/.config/nvim/pywal/chadwal.py &> /dev/null &"

local autocmd = vim.api.nvim_create_autocmd

autocmd("Signal", {
   pattern = "SIGUSR1",
   callback = function()
      require("nvchad.utils").reload()
   end,
})

_G.fzf_focus_nvimtree = function()
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
