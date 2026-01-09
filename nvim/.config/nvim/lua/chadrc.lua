-- This file needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/ui/blob/v3.0/lua/nvconfig.lua
-- Please read that file to know all available options :(

local M = {}
local git_fn = function()
    if
        not vim.b[vim.api.nvim_win_get_buf(vim.g.statusline_winid or 0)].gitsigns_head
        or vim.b[vim.api.nvim_win_get_buf(vim.g.statusline_winid or 0)].gitsigns_git_status
    then
        return ""
    end

    local git_status = vim.b[vim.api.nvim_win_get_buf(vim.g.statusline_winid or 0)].gitsigns_status_dict

    local branch_name = " " .. git_status.head

    return " " .. branch_name
end

M.base46 = {
    theme = "chadwal",
    theme_toggle = { "chadwal", "doomchad" },
    transparency = true,
    hl_override = {
        Comment = { italic = true },
        ["@comment"] = { italic = true },
    },
}

M.nvdash = {
    load_on_startup = true,
    header = {
        "⣿⣿⣿⣟⠿⠙⠌⠈⠈⠁⠀⠀⠀⠀⠁⠀⠈⠘⢻⣽⣿⣿⡿⢛⠿⠋⠽⠿⠁⠀",
        "⣿⣿⣿⡑⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠁⣹⣿⠿⠁⠃⠀⠀⠀⠀⠀⠀",
        "⣿⡎⠃⠀⠀⠀⠀⠀⠠⡀⠀⠁⠀⠀⠀⠀⠀⠀⠀⠀⣻⡆⠀⠀⠀⠀⠀⠀⠀⠀",
        "⣿⣓⠀⠀⠀⠀⠀⠤⠈⠀⣨⡴⠆⢀⠀⠀⠀⠀⠂⠀⠹⠁⠀⠀⠀⠀⠀⠀⠀⠀",
        "⣿⡀⠀⠀⠀⡀⠀⠀⠠⠀⢉⣤⣷⣄⣤⠄⠀⠀⠂⠀⠀⠀⠀⠀⠀⠁⠀⠀⠀⠀",
        "⣿⣷⡤⠀⠂⣁⢠⡐⠒⢪⣭⡿⠙⠙⠀⠀⠀⠀⠄⠀⠀⠄⠀⠀⠀⠀⠀⠀⠀⠀",
        "⣿⣿⣷⣆⡨⡎⣩⣠⡠⢋⣕⡮⠆⠃⠀⠈⠀⠈⠌⠀⠃⠀⠀⠀⠀⠀⠀⠀⠀⠀",
        "⣿⣿⣿⣿⣷⡌⡗⠏⣠⠗⠁⠀⠀⠀⠀⠀⢀⠙⠄⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
        "⣿⣿⣿⣿⣿⣿⣌⠀⠀⠀⠀⠀⠀⢠⡿⠀⡬⠂⠘⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
        "⣿⣿⣿⣿⣿⣿⣿⣿⢦⡀⠀⠀⠐⠋⡁⣜⡞⡠⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
        "⣿⣿⣿⣿⡏⣻⣿⠋⠑⠀⠀⠀⠀⠈⢊⡴⠊⣁⡄⠀⠀⠀⠀⠀⠀⠐⠀⠀⠀⠀",
        "⣿⣿⣿⡿⠀⠉⠀⠀⠀⠀⠀⠀⠀⠀⠀⠰⠊⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
        "⣿⣿⣿⠀⠀⠀⠀⠀⠀⠀⠄⠤⠄⠀⠀⠀⠀⠀⠀⠀⠀⠄⠀⠀⠀⠀⠀⠀⠀⠀",
        "⡿⠩⠈⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠀⠀⠀⠀⠀⠀⠀⠀⠀",
        "⡇⠀⠀⠀⠈⠀⠂⠀⠂⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
        "",
    },

    buttons = {
        { txt = "  Find File", keys = "ff", cmd = "Telescope find_files" },
        { txt = "  Recent Files", keys = "fo", cmd = "Telescope oldfiles" },

        { txt = "─", hl = "NvDashFooter", no_gap = true, rep = true },

        {
            txt = function()
                local stats = require("lazy").stats()
                local ms = math.floor(stats.startuptime) .. " ms"
                return "  Loaded " .. stats.loaded .. "/" .. stats.count .. " plugins in " .. ms
            end,
            hl = "NvDashFooter",
            no_gap = true,
            content = "fit",
        },

        { txt = "─", hl = "NvDashFooter", no_gap = true, rep = true },
    },
}

M.ui = {
    tabufline = {
        lazyload = false,
    },

    statusline = {
        theme = "minimal",
        order = { "mode", "cgit", "%=", "lsp_msg", "%=", "lsp", "cwd" },
        modules = {
            cgit = function()
                return "%#St_gitIcons#" .. git_fn()
            end,
        },
    },

    cmp = {
        format_colors = {
            tailwind = true,
        },
    },
}

M.cheatsheet = {
    theme = "simple", -- simple/grid
}

return M
