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
map({ "n", "x" }, "c", '"_c', { desc = "Change without yanking" })

-- Ctrl-o to ignore dashboard
map("n", "<C-o>", function()
   if vim.bo.filetype == "nvdash" then
      vim.cmd "bdelete"
   else
      vim.cmd "normal! <C-o>"
   end
end, { desc = "Close dashboard or jump back" })

-- fzf-lua
map("n", "<leader>ff", function()
   require("fzf-lua").files {
      cmd = "fd --type f --exclude node_modules --exclude .next --exclude .git",
      cwd_prompt = false,
      -- prompt = 'Files❯ '
   }
end, { desc = "Fzf Find Files" })

map("n", "<leader>fw", "<cmd>FzfLua live_grep<CR>", { desc = "live grep" })
map("n", "<leader>fb", "<cmd>FzfLua buffers<CR>", { desc = "find buffers" })
map("n", "<leader>fh", "<cmd>FzfLua help_tags<CR>", { desc = "help page" })
map("n", "<leader>ma", "<cmd>FzfLua marks<CR>", { desc = "find marks" })
map("n", "<leader>fo", "<cmd>FzfLua oldfiles<CR>", { desc = "find oldfiles" })
map("n", "<leader>fz", "<cmd>FzfLua blines<CR>", { desc = "find in current buffer" })
map("n", "<leader>cm", "<cmd>FzfLua git_commits<CR>", { desc = "git commits" })
map("n", "<leader>gt", "<cmd>FzfLua git_status<CR>", { desc = "git status" })
-- find recent zoxide cd'ed paths
map("n", "<leader>fx", "<cmd>FzfLua zoxide<CR>")

--fzf Insert-mode completion
vim.keymap.set({ "n", "v", "i" }, "<C-x><C-f>", function()
   require("fzf-lua").complete_path()
end, { silent = true, desc = "Fuzzy complete path" })

-- Enter Normal Mode Terminal
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>", { desc = "Enter Normal Mode(Terminal)", silent = true })

-- Go to upper window (Terminal)
vim.keymap.set("t", "<C-j>", "<C-\\><C-N><C-j>", { desc = "General | Go to upper window(Terminal)", silent = true })

-- Go to lower window (Terminal)
vim.keymap.set("t", "<C-k>", "<C-\\><C-N><C-k>", { desc = "General | Go to lower window(Terminal)", silent = true })

-- Go to left window (Terminal)
vim.keymap.set("t", "<C-h>", "<C-\\<C-N><C-h>", { desc = "General | Go to left window(Terminal)", silent = true })

-- Go to right window (Terminal)
vim.keymap.set("t", "<C-l>", "<C-\\><C-N><C-l>", { desc = "General | Go to right window(Terminal)", silent = true })
