require "nvchad.mappings"
local map = vim.keymap.set

-- COMMAND MODE & BASIC EDITING
map("n", ";", ":", { desc = "cmd enter command mode" })
map("n", ":", ";", { desc = "repeat last f/t jump" })
map("i", "jk", "<ESC>", { desc = "exit insert mode" })
-- map("n", "U", "<C-r>", { desc = "redo" })
map("n", "Y", "yy", { desc = "yank entire line" })
map("n", "J", "mzJ`z", { desc = "join lines preserving cursor position" })

-- SELECTION & SAVING
map({ "n", "v" }, "<C-a>", "<Esc>gg0vG$", { desc = "select all" })
map("i", "<C-s>", "<ESC><cmd>w<CR>", { desc = "file save from insert mode", silent = true })

-- LINE/SELECTION MOVEMENT
map("n", "<M-j>", ":m .+1<CR>==", { desc = "move line down" })
map("n", "<M-k>", ":m .-2<CR>==", { desc = "move line up" })
map("v", "<M-j>", ":m '>+1<CR>gv=gv", { desc = "move selection down" })
map("v", "<M-k>", ":m '<-2<CR>gv=gv", { desc = "move selection up" })

-- INSERT MODE NAVIGATION (Emacs-style)
map("i", "<C-n>", "<Down>", { noremap = true, desc = "move down" })
map("i", "<C-p>", "<Up>", { noremap = true, desc = "move up" })
map("i", "<C-b>", "<Left>", { noremap = true, desc = "move left" })
map("i", "<C-f>", "<Right>", { noremap = true, desc = "move right" })
map("i", "<C-e>", "<C-o>$", { noremap = true, desc = "move to end of line" })
map("i", "<M-b>", "<C-o>b", { noremap = true, desc = "move backward one word" })

-- CUSTOM EDITING OPERATIONS
map("n", "yc", "yy<cmd>normal gcc<CR>p", { noremap = true, desc = "duplicate and comment out original line" })
map("n", "<BS>", "X", { desc = "backspace delete" })
map("n", "cc", '"_cc', { desc = "change line without yanking" })
map("n", "<leader>c", '"_c', { noremap = true, desc = "change without yanking" })
map("n", "<leader>d", '"_d', { noremap = true, desc = "delete without yanking" })

-- NAVIGATION SHORTCUTS
map({ "n", "v" }, "gh", "_", { noremap = true, desc = "goto first non-blank character" })
map({ "n", "v" }, "gl", "$", { noremap = true, desc = "goto end of line" })

-- SCROLLING & CENTERING
map("n", "<C-d>", "<C-d>zz", { desc = "scroll down half page and center", silent = true })
map("n", "<C-u>", "<C-u>zz", { desc = "scroll up half page and center", silent = true })
map("n", "<C-f>", "<C-f>zz", { desc = "scroll down full page and center", silent = true })
map("n", "<C-b>", "<C-b>zz", { desc = "scroll up full page and center", silent = true })
map("n", "G", "Gzz", { noremap = true, desc = "goto last line and center" })
map("n", "n", "nzzzv", { noremap = true, desc = "next search result centered" })
map("n", "N", "Nzzzv", { noremap = true, desc = "previous search result centered" })
map("n", "g*", "g*zz", { noremap = true, desc = "search partial word forward centered" })
map("n", "g#", "g#zz", { noremap = true, desc = "search partial word backward centered" })

-- SEARCH OPERATIONS
map("n", "*", [[:keepjumps normal! mi*`i<CR>]], { desc = "search word under cursor stay put" })
map("n", "#", [[:keepjumps normal! mi#`i<CR>]], { desc = "search word backward stay put" })

map("n", "g/", function()
   local cur_line = vim.fn.line "."
   local search_term = vim.fn.getreg "/"

   if search_term == "" then
      print "No search pattern set!"
      return
   end

   vim.cmd("silent! vimgrep /" .. search_term .. "/j %")

   local qf_list = vim.fn.getqflist()
   if #qf_list == 0 then
      return
   end

   local target_idx = 1
   for i, item in ipairs(qf_list) do
      if item.lnum <= cur_line then
         target_idx = i
      else
         break
      end
   end

   vim.cmd "cw"
   vim.cmd(target_idx .. "cc")
   vim.cmd "wincmd p"
end, { desc = "quickfix populate with search results" })

-- SEARCH & REPLACE
map("v", "R", '"hy:.,$s/<C-r>h//gc<left><left><left>', { desc = "replace selection from cursor to end" })
map(
   "n",
   "<leader>ra",
   [[:%s/\<<C-r><C-w>\>//gc<Left><Left><Left>]],
   { desc = "replace all instances of word under cursor" }
)

-- FOLDING
map("n", "<leader>zf", "vatzf", { desc = "fold html/xml tag" })
map("n", "<leader>zF", "vaBzf", { desc = "fold code block" })

-- REFACTORING
map("n", "<leader>rc", [[:s/\([a-zA-Z]\)\(-\)\([a-zA-Z]\)/\1\u\3/g<CR>]], { desc = "refactor kebab to camel case" })
map("n", "<leader>rn", [[:%s/\d\+/number/g<CR>]], { desc = "refactor numbers to 'number'" })
map("n", "<leader>rs", [[:%s/"[^"]*"/string/g<CR>]], { desc = "refactor strings to 'string'" })
map("n", "<leader>rb", [[:%s/\v(true|false)/boolean/g<CR>]], { desc = "refactor booleans to 'boolean'" })

-- FZF-LUA
map("n", "<leader>ff", function()
   require("fzf-lua").files {
      cmd = "fd --type f --exclude node_modules --exclude .next --exclude .git",
      cwd_prompt = false,
   }
end, { desc = "fzf find files" })

map("n", "<leader>fd", function()
   require("fzf-lua").files {
      cmd = "fd --type d --exclude node_modules --exclude .next --exclude .git",
      cwd_prompt = false,
      previewer = false,
      winopts = {
         width = 0.5,
      },
   }
end, { desc = "fzf find directories" })

map("n", "<leader>fw", "<cmd>FzfLua live_grep<CR>", { desc = "fzf live grep" })
map("n", "<leader>fb", "<cmd>FzfLua buffers<CR>", { desc = "fzf find buffers" })
map("n", "<leader>fh", "<cmd>FzfLua help_tags<CR>", { desc = "fzf help page" })
map("n", "<leader>ma", "<cmd>FzfLua marks<CR>", { desc = "fzf find marks" })
map("n", "<leader>fo", "<cmd>FzfLua oldfiles<CR>", { desc = "fzf find oldfiles" })
map("n", "<leader>fz", "<cmd>FzfLua blines<CR>", { desc = "fzf find in current buffer" })
map("n", "<leader>cm", "<cmd>FzfLua git_commits<CR>", { desc = "fzf git commits" })
map("n", "<leader>gt", "<cmd>FzfLua git_status<CR>", { desc = "fzf git status" })
map("n", "<leader>fx", "<cmd>FzfLua zoxide<CR>", { desc = "fzf find recent zoxide cd paths" })
map({ "n", "v", "i" }, "<C-x><C-f>", function()
   require("fzf-lua").complete_path()
end, { silent = true, desc = "fzf fuzzy complete path" })

-- WINDOW NAVIGATION
map("n", "<C-h>", "<C-w>h", { desc = "window goto left" })
map("n", "<C-j>", "<C-w>j", { desc = "window goto lower" })
map("n", "<C-k>", "<C-w>k", { desc = "window goto upper" })
map("n", "<C-l>", "<C-w>l", { desc = "window goto right" })

-- TERMINAL MODE
map("t", "<Esc>", "<C-\\><C-n>", { desc = "terminal exit mode" })
map("t", "<C-h>", "<cmd>wincmd h<CR>", { desc = "window goto left" })
map("t", "<C-j>", "<cmd>wincmd j<CR>", { desc = "window goto lower" })
map("t", "<C-k>", "<cmd>wincmd k<CR>", { desc = "window goto upper" })
map("t", "<C-l>", "<cmd>wincmd l<CR>", { desc = "window goto right" })

-- WINDOW RESIZING
map("n", "<C-Up>", ":resize -2<CR>", { desc = "window decrease height" })
map("n", "<C-Down>", ":resize +2<CR>", { desc = "window increase height" })
map("n", "<C-Left>", ":vertical resize -2<CR>", { desc = "window decrease width" })
map("n", "<C-Right>", ":vertical resize +2<CR>", { desc = "window increase width" })

map("t", "<C-Up>", "<cmd>resize -2<CR>", { desc = "window decrease height" })
map("t", "<C-Down>", "<cmd>resize +2<CR>", { desc = "window increase height" })
map("t", "<C-Left>", "<cmd>vertical resize -2<CR>", { desc = "window decrease width" })
map("t", "<C-Right>", "<cmd>vertical resize +2<CR>", { desc = "window increase width" })

-- GIT (Gitsigns)
map("n", "<leader>gd", "<cmd>Gitsigns toggle_deleted<cr>", { desc = "git toggle deleted" })
map("n", "<leader>gb", "<cmd>Gitsigns blame_line<cr>", { desc = "git blame line" })
