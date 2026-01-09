require "nvchad.autocmds"
local api = vim.api

api.nvim_create_autocmd("BufEnter", {
    callback = function()
        vim.cmd "silent! lcd %:p:h"
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
