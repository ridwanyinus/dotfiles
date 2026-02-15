require "nvchad.options"
local o = vim.o

-- DISPLAY
o.relativenumber = true
o.number = true
o.wrap = false
o.scrolloff = 10
o.sidescrolloff = 8
-- o.list = true
o.termguicolors = true
o.background = "dark"
o.fillchars = "eob: ,fold: "
o.title = true
o.cmdheight = 0
o.cursorlineopt = "both"
o.cursorline = true

-- ENCODING
vim.scriptencoding = "utf-8"
o.encoding = "utf-8"

-- SEARCH
o.ignorecase = true
o.smartcase = true

-- BACKUP
o.backup = true
o.swapfile = false
local backupdir = vim.fn.stdpath "data" .. "/backup"
if vim.fn.isdirectory(backupdir) == 0 then
   vim.fn.mkdir(backupdir, "p")
end
o.backupdir = backupdir

-- EDITING
o.backspace = "start,eol,indent"
o.keywordprg = ":help"
vim.opt.iskeyword:append "-"

-- FOLDING
o.foldlevelstart = 99
o.foldtext = "v:lua.fold_text()"
o.foldmethod = "expr"
o.foldexpr = "v:lua.vim.treesitter.foldexpr()"

vim.opt.inccommand = "split"
vim.opt.splitright = true -- New vertical splits open to the right
vim.opt.splitbelow = true -- New horizontal splits open below

function _G.fold_text()
   local line = vim.fn.getline(vim.v.foldstart)
   local line_count = vim.v.foldend - vim.v.foldstart + 1
   local cleaned_line = line:gsub("^%s*", "")
   return " 󰁂  " .. cleaned_line .. " ... (" .. line_count .. " lines)"
end

-- o.mouse = "a"
-- o.shell = "fish"
o.autoread = true

-- Increase oldfiles history
vim.opt.shada = { "'500", "<50", "s10", "h" }

-- Command-line completion
o.wildmenu = true
o.wildmode = "longest:full,full"
vim.opt.wildignore:append { "*.o", "*.obj", "*.pyc", "*.class", "*.jar" }
