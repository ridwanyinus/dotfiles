require "nvchad.autocmds"

local api = vim.api

api.nvim_create_autocmd("BufEnter", {
    callback = function()
        vim.cmd "silent! lcd %:p:h"
    end,
})
