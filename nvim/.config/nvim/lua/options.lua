require "nvchad.options"
local o = vim.o
local opt = vim.opt

-- DISPLAY
o.relativenumber = true
o.number = true
o.wrap = true
o.linebreak = true
o.scrolloff = 8
o.signcolumn = "yes"
o.sidescrolloff = 8
o.tabstop = 4
o.shiftwidth = 4
o.expandtab = false
o.list = false
-- opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

-- Fill chars
opt.fillchars:append {
   diff = "░",
   eob = " ",
   fold = "⋯",
   foldopen = "▼",
   foldclose = "▶",
   foldsep = "┊",
   msgsep = "━",
}
o.termguicolors = true
o.background = "dark"
o.fillchars = "eob: ,fold: "
o.title = true
o.winborder = "rounded"
o.pumborder = "rounded"
o.cmdheight = 1
o.cursorlineopt = "both"
o.cursorline = true
o.shortmess = table.concat { -- Use abbreviations and short messages in command menu line.
   "f", -- Use "(3 of 5)" instead of "(file 3 of 5)".
   "i", -- Use "[noeol]" instead of "[Incomplete last line]".
   "l", -- Use "999L, 888C" instead of "999 lines, 888 characters".
   "m", -- Use "[+]" instead of "[Modified]".
   "n", -- Use "[New]" instead of "[New File]".
   "r", -- Use "[RO]" instead of "[readonly]".
   "w", -- Use "[w]", "[a]" instead of "written", "appended".
   "x", -- Use "[dos]", "[unix]", "[mac]" instead of "[dos format]", "[unix format]", "[mac format]".
   "o", -- Overwrite message for writing a file with subsequent message.
   "O", -- Message for reading a file overwrites any previous message.
   "s", -- Disable "search hit BOTTOM, continuing at TOP" such messages.
   "t", -- Truncate file message at the start if it is too long.
   "T", -- Truncate other messages in the middle if they are too long.
   "I", -- Don't give the :intro message when starting.
   "c", -- Don't give ins-completion-menu messages.
   "F", -- Don't give the file info when editing a file.
   -- "W", -- Don't give "written" or "[w]" when writing a file.
}

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
-- vim.o.foldmethod = "expr"
-- vim.o.foldexpr = "v:lua.vim.treesitter.foldexpr()"
-- vim.o.foldlevel = 99
o.foldlevelstart = 99
o.foldenable = false
o.foldcolumn = "0"
o.foldtext = ""
-- vim.o.foldtext = "v:lua.CustomFoldText()"

function _G.CustomFoldText()
   local start_line = vim.fn.getline(vim.v.foldstart)
   local end_line = vim.fn.getline(vim.v.foldend)

   start_line = start_line:gsub("\t", string.rep(" ", vim.o.tabstop))
   end_line = vim.trim(end_line)

   return start_line .. " ... " .. end_line
end

vim.opt.inccommand = "split"
vim.opt.splitright = true -- New vertical splits open to the right
vim.opt.splitbelow = true -- New horizontal splits open below

-- o.mouse = "a"
-- o.shell = "fish"
o.autoread = true

-- Increase oldfiles history
vim.opt.shada = { "'500", "<50", "s10", "h" }

-- Command-line completion
o.wildmenu = true
o.wildmode = "longest:full,full"
vim.opt.wildignore:append { "*.o", "*.obj", "*.pyc", "*.class", "*.jar" }

vim.cmd [[
  highlight LineNr ctermfg=grey guifg=#aaaaaa
  highlight CursorLineNr ctermfg=white guifg=white gui=bold cterm=bold
]]
