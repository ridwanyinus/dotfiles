require "nvchad.mappings"
-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

map({ "n", "v" }, "<C-a>", "<Esc>gg0vG$", { desc = "Select all (works everywhere)" })
map("i", "<C-s>", "<ESC><cmd>w<CR>", { desc = "Save in insert" })

map("n", "<M-j>", ":m .+1<CR>==", { desc = "Move line down" })
map("n", "<M-k>", ":m .-2<CR>==", { desc = "Move line up" })

map("v", "<M-j>", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
map("v", "<M-k>", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })
