require "custom.commands"

vim.g.base46_cache = vim.fn.stdpath "data" .. "/base46/"
vim.g.mapleader = " "
vim.api.nvim_set_hl(0, "DiagnosticUnderlineHint", { undercurl = true, sp = "#666666" })

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
-- require "autocmd"

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

-- vim.cmd "runtime macros/matchit.vim"
vim.cmd "packadd! matchit"

-- Experimental UI2: floating cmdline and messages
require("vim._core.ui2").enable {
   enable = true,
   msg = {
      targets = {
         [""] = "msg",
         empty = "cmd",
         bufwrite = "msg",
         confirm = "cmd",
         emsg = "pager",
         echo = "msg",
         echomsg = "msg",
         echoerr = "pager",
         completion = "cmd",
         list_cmd = "pager",
         lua_error = "pager",
         lua_print = "msg",
         progress = "pager",
         rpc_error = "pager",
         quickfix = "msg",
         search_cmd = "cmd",
         search_count = "cmd",
         shell_cmd = "pager",
         shell_err = "pager",
         shell_out = "pager",
         shell_ret = "msg",
         undo = "msg",
         verbose = "pager",
         wildlist = "cmd",
         wmsg = "msg",
         typed_cmd = "cmd",
      },
      cmd = {
         height = 0.5,
      },
      dialog = {
         height = 0.5,
      },
      msg = {
         height = 0.3,
         timeout = 3000,
      },
      pager = {
         height = 0.5,
      },
   },
}
