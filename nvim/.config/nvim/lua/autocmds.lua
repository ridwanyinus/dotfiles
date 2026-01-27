require "nvchad.autocmds"
local api = vim.api
local autocmd = vim.api.nvim_create_autocmd

api.nvim_create_autocmd("VimEnter", {
    callback = function()
        -- Only change cwd on startup when opening a file/directory
        if vim.fn.argc() > 0 then
            vim.cmd "silent! lcd %:p:h"
        end
    end,
})

local function has_real_buffers()
    local buffers = api.nvim_list_bufs()
    local real_buffers = 0

    for _, buf in ipairs(buffers) do
        if api.nvim_buf_is_valid(buf) and api.nvim_buf_is_loaded(buf) then
            local buftype = api.nvim_get_option_value("buftype", { buf = buf })
            local bufname = api.nvim_buf_get_name(buf)
            local listed = api.nvim_get_option_value("buflisted", { buf = buf })

            if buftype == "" and listed then
                if bufname ~= "" or api.nvim_get_option_value("modified", { buf = buf }) then
                    real_buffers = real_buffers + 1
                end
            end
        end
    end

    return real_buffers > 0
end

api.nvim_create_autocmd({ "BufDelete", "BufWipeout" }, {
    group = api.nvim_create_augroup("ShowDashboard", { clear = true }),
    callback = function(args)
        local buftype = api.nvim_get_option_value("buftype", { buf = args.buf })
        if buftype ~= "" then
            return
        end

        vim.schedule(function()
            vim.defer_fn(function()
                if not has_real_buffers() then
                    local current_buf = api.nvim_get_current_buf()
                    local current_ft = api.nvim_get_option_value("filetype", { buf = current_buf })

                    if current_ft ~= "nvdash" then
                        vim.cmd "Nvdash"
                    end
                end
            end, 10)
        end)
    end,
})

-- highlight yanked text
autocmd("TextYankPost", {
    pattern = "*",
    command = "silent! lua vim.highlight.on_yank({ timeout = 100 })",
})

-- jump to last edit position on opening file
autocmd("BufReadPost", {
    pattern = "*",
    callback = function(ev)
        if vim.fn.line "'\"" > 1 and vim.fn.line "'\"" <= vim.fn.line "$" then
            vim.cmd 'exe "normal! g\'\\""'
        end
    end,
})
