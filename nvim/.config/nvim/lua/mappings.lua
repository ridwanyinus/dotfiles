require "nvchad.mappings"
local map = vim.keymap.set

-- COMMAND MODE & BASIC EDITING
map("n", ";", ":", { desc = "cmd enter mode" })
map("n", ":", ";", { desc = "cmd repeat f/t jump" })
map("i", "jk", "<ESC>", { desc = "edit exit insert mode" })
map("n", "Y", "yy", { desc = "edit yank entire line" })
map("n", "J", "mzJ`z", { desc = "edit join lines (preserve cursor)" })
map("n", "gs", "a<CR><Esc>k$", { desc = "edit split line below" })

-- SELECTION & SAVING
map({ "n", "v" }, "<C-a>", "<Esc>gg0vG$", { desc = "edit select all" })
map("i", "<C-s>", "<ESC><cmd>w<CR>", { desc = "file save", silent = true })

-- LINE/SELECTION MOVEMENT
map("n", "<A-j>", "<cmd>m .+1<CR>==", { desc = "edit move line down" })
map("n", "<A-k>", "<cmd>m .-2<CR>==", { desc = "edit move line up" })
map("v", "<A-j>", ":m '>+1<CR>gv=gv", { desc = "edit move selection down" })
map("v", "<A-k>", ":m '<-2<CR>gv=gv", { desc = "edit move selection up" })

-- INSERT MODE NAVIGATION
map("i", "<C-e>", "<C-g>u<C-o>$", { desc = "cursor line end" })
map("i", "<M-b>", "<C-g>u<C-o>b", { desc = "cursor word back" })

map("i", "<M-d>", "<C-g>u<C-o>dw", { desc = "delete word forward" })

map("i", "<C-n>", "<Down>", { noremap = true })
map("i", "<C-p>", "<Up>", { noremap = true })
map("i", "<C-b>", "<Left>", { noremap = true })
map("i", "<C-f>", "<Right>", { noremap = true })

-- CUSTOM EDITING OPERATIONS
map("n", "yc", "yy<cmd>normal gcc<CR>p", { noremap = true, desc = "edit duplicate + comment" })
map("n", "<BS>", "X", { desc = "edit backspace delete" })
map("n", "cc", '"_cc', { desc = "edit change line (no yank)" })
map("n", "<leader>c", '"_c', { noremap = true, desc = "edit change (no yank)" })
map("n", "<leader>d", '"_d', { noremap = true, desc = "edit delete (no yank)" })

-- NAVIGATION SHORTCUTS
map({ "n", "v" }, "gh", "_", { noremap = true, desc = "cursor line start" })
map({ "n", "v" }, "gl", "$", { noremap = true, desc = "cursor line end" })

-- SCROLLING & CENTERING
map("n", "<C-d>", "<C-d>zz", { desc = "scroll half down + center", silent = true })
map("n", "<C-u>", "<C-u>zz", { desc = "scroll half up + center", silent = true })
map("n", "<C-f>", "<C-f>zz", { desc = "scroll page down + center", silent = true })
map("n", "<C-b>", "<C-b>zz", { desc = "scroll page up + center", silent = true })
map("n", "G", "Gzz", { noremap = true, desc = "cursor goto bottom + center" })
map("n", "n", "nzzzv", { noremap = true, desc = "search next + center" })
map("n", "g*", "g*zz", { noremap = true, desc = "search word partial + center" })
map("n", "g#", "g#zz", { noremap = true, desc = "search word partial back + center" })

-- WINDOW OPERATIONS
map({ "n", "t" }, "<C-Up>", "<cmd>resize -2<CR>", { desc = "window decrease height" })
map({ "n", "t" }, "<C-Down>", "<cmd>resize +2<CR>", { desc = "window increase height" })
map({ "n", "t" }, "<C-Left>", "<cmd>vertical resize -2<CR>", { desc = "window decrease width" })
map({ "n", "t" }, "<C-Right>", "<cmd>vertical resize +2<CR>", { desc = "window increase width" })

-- WINDOW NAVIGATION
map({ "n", "t" }, "<C-h>", "<cmd>wincmd h<CR>", { desc = "window goto left" })
map({ "n", "t" }, "<C-j>", "<cmd>wincmd j<CR>", { desc = "window goto lower" })
map({ "n", "t" }, "<C-k>", "<cmd>wincmd k<CR>", { desc = "window goto upper" })
map({ "n", "t" }, "<C-l>", "<cmd>wincmd l<CR>", { desc = "window goto right" })

-- Tab Management
map("n", "<C-W>C", function()
   vim.cmd(string.rep("tabclose|", vim.v.count1))
end, { desc = "tab close (supports count)" })
map("n", "<leader>tn", ":tabnew<CR>", { desc = "tab new" })
map("n", "tx", ":tabclose<Return>", { desc = "tab close current" })

map("t", "<Esc>", "<C-\\><C-n>", { desc = "terminal exit mode" })

-- SEARCH OPERATIONS
map("n", "/", "ms/", { desc = "search forward" })
map("n", "?", "ms?", { desc = "search backward" })
map("n", "*", "ms*`s", { desc = "search word forward" })
map("n", "#", "ms#`s", { desc = "search word backward" })

-- SEARCH & REPLACE
map("v", "R", '"hy:.,$s/<C-r>h//gc<left><left><left>', { desc = "search replace selection" })

-- FZF-LUA
map("n", "<leader>ff", function()
   require("fzf-lua").files {
      cmd = "fd --type f --exclude node_modules --exclude .next --exclude .git",
   }
end, { desc = "file find" })

map("n", "<leader>fd", function()
   require("custom.utils").fzf_focus_nvimtree()
end, { desc = "file find directories" })
map("n", "<leader>s,", "<cmd>FzfLua buffers<CR>", { desc = "buffer find" })
map("n", "<leader>sh", "<cmd>FzfLua help_tags<CR>", { desc = "help find tags" })
map("n", "<leader>sw", "<cmd>FzfLua live_grep_native<CR>", { desc = "search live grep" })
map("n", "<leader>Z", "<cmd>FzfLua grep_cword<cr>", { desc = "search word under cursor" })
map("n", "<leader>sB", "<cmd>FzfLua grep_curbuf<CR>", { desc = "search current buffer" })
map("n", "<leader>ma", "<cmd>FzfLua marks<CR>", { desc = "marks find" })
map("n", "<leader>fo", "<cmd>FzfLua oldfiles<CR>", { desc = "file find recent" })
map("n", "<leader>gt", "<cmd>FzfLua git_status<CR>", { desc = "git status" })

-- NAVIGATION
map("n", "]f", function()
   require("custom.utils").nav_dir_files(vim.v.count1)
end, { desc = "file next" })
map("n", "[f", function()
   require("custom.utils").nav_dir_files(-vim.v.count1)
end, { desc = "file prev" })

-- LSP
map("n", "<leader>de", function()
   vim.diagnostic.open_float()
end, { desc = "lsp diagnostics show" })
map("n", "<leader>ss", "<cmd>FzfLua lsp_document_symbols<CR>", { desc = "lsp symbols" })

-- TREESITTER TEXTOBJECTS
map({ "n", "x", "o" }, "]m", function()
   require("nvim-treesitter-textobjects.move").goto_next_start("@function.outer", "textobjects")
end, { desc = "nav function next" })
map({ "n", "x", "o" }, "]]", function()
   require("nvim-treesitter-textobjects.move").goto_next_start("@class.outer", "textobjects")
end, { desc = "nav class next" })
map({ "n", "x", "o" }, "]o", function()
   require("nvim-treesitter-textobjects.move").goto_next_start({ "@loop.inner", "@loop.outer" }, "textobjects")
end, { desc = "nav loop next" })
map({ "n", "x", "o" }, "]s", function()
   require("nvim-treesitter-textobjects.move").goto_next_start("@local.scope", "locals")
end, { desc = "nav scope next" })
map({ "n", "x", "o" }, "]z", function()
   require("nvim-treesitter-textobjects.move").goto_next_start("@fold", "folds")
end, { desc = "nav fold next" })

map({ "n", "x", "o" }, "]M", function()
   require("nvim-treesitter-textobjects.move").goto_next_end("@function.outer", "textobjects")
end, { desc = "nav function end next" })
map({ "n", "x", "o" }, "][", function()
   require("nvim-treesitter-textobjects.move").goto_next_end("@class.outer", "textobjects")
end, { desc = "nav class end next" })

map({ "n", "x", "o" }, "[m", function()
   require("nvim-treesitter-textobjects.move").goto_previous_start("@function.outer", "textobjects")
end, { desc = "nav function prev" })
map({ "n", "x", "o" }, "[[", function()
   require("nvim-treesitter-textobjects.move").goto_previous_start("@class.outer", "textobjects")
end, { desc = "nav class prev" })

map({ "n", "x", "o" }, "[M", function()
   require("nvim-treesitter-textobjects.move").goto_previous_end("@function.outer", "textobjects")
end, { desc = "nav function end prev" })
map({ "n", "x", "o" }, "[]", function()
   require("nvim-treesitter-textobjects.move").goto_previous_end("@class.outer", "textobjects")
end, { desc = "nav class end prev" })

map({ "n", "x", "o" }, "]d", function()
   require("nvim-treesitter-textobjects.move").goto_next("@conditional.outer", "textobjects")
end, { desc = "nav conditional next" })
map({ "n", "x", "o" }, "[d", function()
   require("nvim-treesitter-textobjects.move").goto_previous("@conditional.outer", "textobjects")
end, { desc = "nav conditional prev" })

-- TEXTOBJECTS
map({ "x", "o" }, "am", function()
   require("nvim-treesitter-textobjects.select").select_textobject("@function.outer", "textobjects")
end, { desc = "textobj function outer" })
map({ "x", "o" }, "im", function()
   require("nvim-treesitter-textobjects.select").select_textobject("@function.inner", "textobjects")
end, { desc = "textobj function inner" })
map({ "x", "o" }, "ac", function()
   require("nvim-treesitter-textobjects.select").select_textobject("@class.outer", "textobjects")
end, { desc = "textobj class outer" })
map({ "x", "o" }, "ic", function()
   require("nvim-treesitter-textobjects.select").select_textobject("@class.inner", "textobjects")
end, { desc = "textobj class inner" })
map({ "x", "o" }, "as", function()
   require("nvim-treesitter-textobjects.select").select_textobject("@local.scope", "locals")
end, { desc = "textobj scope outer" })

map({ "x", "o" }, "ai", function()
   require("nvim-treesitter-textobjects.select").select_textobject("@conditional.outer", "textobjects")
end, { desc = "textobj conditional outer" })
map({ "x", "o" }, "ii", function()
   require("nvim-treesitter-textobjects.select").select_textobject("@conditional.inner", "textobjects")
end, { desc = "textobj conditional inner" })

map({ "x", "o" }, "al", function()
   require("nvim-treesitter-textobjects.select").select_textobject("@loop.outer", "textobjects")
end, { desc = "textobj loop outer" })
map({ "x", "o" }, "il", function()
   require("nvim-treesitter-textobjects.select").select_textobject("@loop.inner", "textobjects")
end, { desc = "textobj loop inner" })

-- OPENCODE
map({ "n", "t" }, "<C-.>", function()
   require("opencode").toggle()
end, { desc = "Toggle opencode" })
