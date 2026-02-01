require "nvchad.options"
local o = vim.o

-- DISPLAY
o.relativenumber = true
o.number = true
o.wrap = false
o.scrolloff = 10
-- o.list = true
o.termguicolors = true
o.background = "dark"
o.fillchars = "eob: ,fold: "

-- ENCODING
vim.scriptencoding = "utf-8"
o.encoding = "utf-8"
o.fileencoding = "utf-8"

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

-- FOLDING
o.foldlevelstart = 99
o.foldtext = "v:lua.fold_text()"

function _G.fold_text()
   local line = vim.fn.getline(vim.v.foldstart)
   local line_count = vim.v.foldend - vim.v.foldstart + 1
   local cleaned_line = line:gsub("^%s*", "")
   return " 󰁂  " .. cleaned_line .. " ... (" .. line_count .. " lines)"
end

-- SHELL (commented out)
-- o.mouse = "a"
-- o.shell = "fish"
